module Multisort
  module Sorter
    include Contracts::Core
    C = Contracts

    Thread::abort_on_exception = true

    def self.main_sort(data, threadNum, timer)
      # delegation and tasks presented here
      $semaphore = Mutex.new
      
      $mainBucket = Array.new()
      if data.count > 2
        build_buckets(data, threadNum)
      else
        return bubble_sort(data)
      end
      
      $sortingThread = Thread.new{thread_handler}
      watchdogThread = Thread.new{watchdog(timer)}
      
      $sortingThread.join
      
      if watchdogThread.alive?
          Thread.kill(watchdogThread)
      end
      watchdogThread.join
      
      return $mainBucket.first
    end

    def self.watchdog(timer)
      sleep timer
      if $sortingThread.alive?
        $sortingThread.raise("Thread Death")
      end
    end

    def self.build_buckets(data, numThreads)
      dataclone = data.clone
      while dataclone.length > 1 do
        $mainBucket.push(dataclone.shift(2))
      end

      if dataclone.length == 1
        $mainBucket.push(Array.new(1, dataclone.shift))
      end

    end

    def self.thread_handler
      # given initial data input, handles thread operations with thread_sort and combine_bucket
      begin
        while $mainBucket.count != 1
          threads = Array.new
          (0..($mainBucket.count-1)).each do |rank|
            threads << Thread.new do
              thread_sort(rank)
            end
          end
                    
          # ref http://stackoverflow.com/questions/9095316/handling-exceptions-raised-in-a-ruby-thread
          threads.each(&:join)
        
          threads = Array.new
          $threadBuckets = Array.new()
          (0..($mainBucket.count/2).floor-1).each do |rank|
            threads << Thread.new do
              combine_bucket(rank)
            end
          end
        
          threads.each(&:join)
          if $mainBucket.count % 2 == 1
            $threadBuckets.push($mainBucket.last)
          end
          $mainBucket = $threadBuckets
        end
        return
      rescue Exception => e
        puts "WatchdogExpiredError: Watchdog has elapsed its time."
      end
      exit
    end

    def self.thread_sort(rank)
      # thread sort operations parsed here
      subBucket = $mainBucket[rank]
      bubble_sort($mainBucket[rank])

      $semaphore.lock
        $mainBucket[rank] = subBucket
      $semaphore.unlock
    end
    
    def self.combine_bucket(rank)
      combinedBucket = merge_sorted_arrays($mainBucket[2*rank], $mainBucket[(2*rank)+1])
      
      $semaphore.lock
        $threadBuckets.push(combinedBucket)
      $semaphore.unlock
    end
    
    def self.bubble_sort(array)
      n = array.length
      loop do
        swapped = false
        (n-1).times do |i|
          if array[i] > array[i+1]
            array[i], array[i+1] = array[i+1], array[i]
            swapped = true
          end
        end
        break if not swapped
      end
      return array
    end
    
    def self.merge_sorted_arrays(array1, array2)
      combinedArray = Array.new
      while (!array1.empty? && !array2.empty?)
        if array1.first <= array2.first
          combinedArray.push(array1.shift)
        else
          combinedArray.push(array2.shift)
        end
      end
      return combinedArray + array1 + array2
    end

  end # Sorter
end # Multisort