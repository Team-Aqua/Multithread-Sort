module Multisort
  module Sorter

    # Contract
    def main_sort(data, time)
      # main sort of process
      # delegation and tasks presented here
      # pre       data_loaded = true
      #           data_cleaned = true
      #           sort_status = false
      #           time_limit
      $semaphore = Mutex.new
      
      $mainBucket = Array.new()
      build_buckets(data)
      sortingThread = Thread.new{thread_handler}
      watchdogThread = Thread.new{watchdog(time)}
      
      sortingThread.abort_on_exception = true
      sortingThread.join
      watchdog.join
      
      if sortingThread == "dead"
          Thread.list.each{|t| Thread.kill(t)}
      end
      
      puts $mainBucket
    end

    # Contract
    def watchdog(time)
      # task timer
      # ends process if watchdog value is passed
      # watchdog value represented in seconds
      # pre       time_limit
      sleep time
      if sortingThread.alive?
          Thread.kill(sortingThread)
      end
    end

    # Contract
    def build_buckets(data)
      # main function, goal is to build buckets using data
      # each initial bucket has 2 data points
      # pre       data loaded
      # post      bucket containing data
      dataclone = data.clone
      sizeOfBuckets = (@data.count/@numberOfThreads).floor
      while dataclone.length > sizeOfBuckets-1 do
          $mainBucket.push(dataclone.shift(sizeOfBuckets))
      end
      
      # Handles the exception if there is an odd number of values in the dataset.
      dataclone.each do |val|
        $mainBucket[3].push(val)
      end
    end

    def thread_handler
      # given initial data input, handles thread operations with thread_sort and combine_bucket
      # pre       data
      # post      completed thread operation
      
      while $mainBucket.count != 1
        # Sort sub buckets in main bucket.
        threads = Array.new
        (0..($mainBucket.count-1)).each do |rank|
          threads << Thread.new do
            thread_sort(rank)
          end
        end
                  
        # ref http://stackoverflow.com/questions/9095316/handling-exceptions-raised-in-a-ruby-thread
        threads.each(&:join)
      
        # combine sub buckets
        threads = Array.new
        threadBuckets = Array.new()
        (0..($mainBucket.count/2).floor-1).each do |rank|
          threads << Thread.new do
            combine_bucket(rank)
          end
        end
      
        threads.each(&:join)
        $mainBucket = threadBuckets
      end
    end

    # Contract
    def thread_sort(rank)
      # thread sort operations parsed here
      # Exceptions: thread-based exceptions
      # pre       data
      # post      sorted data
    
      # sort sub bucket.
      subBucket = $mainBucket[rank]
      quick_sort($mainBucket[rank])
    
      # write bucket back to $mainBucket
      $semaphore.lock
        $mainBucket[rank] = subBucket
      $semaphore.unlock
    end

    # Contract
    def combine_bucket(rank)
      # combines bucket with another bucket
      # combines data, then performs thread_sort again
      # pre       two sorted buckets
      # post      single sorted bucket
      
      # combine buckets
      combinedBucket = merge_sorted_arrays($mainBucket[2*rank], $mainBucket[(2*rank)+1])
      
      # Write combined bucket to bucket list
      $semaphore.lock
        threadBuckets.push(combinedBucket)
      $semaphore.unlock
    end
    
    def quick_sort(array)
        sl = array.clone
        return sl if sl.size <= 1
        pivot = sl.pop
        left, right = sl.partition { |e| e < pivot }
        quick_sort(left) + [pivot] + quick_sort(right)
    end
    
    def merge_sorted_arrays(array1, array2)
      combinedArray = Array.new
      
      while (!array1.empty? || !array2.empty?)
        if array1.first >= array2.first
          combinedArray.push(array1.shift)
        else
          combinedArray.push(array1.shift)
        end
      end
      
      return combinedArray + array1 + array2
    end

  end # Sorter
end # Multisort
