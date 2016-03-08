module Multisort
  module Sorter
    include Contracts::Core
    C = Contracts

    #Contract C::And[MContracts::SortData] => C::None
    def main_sort(data, time)
      # main sort of process
      # delegation and tasks presented here
      # pre       data_loaded = true
      #           data_cleaned = true
      #           sort_status = false
      #           time_limit
      $semaphore = Mutex.new
      
      @mainBucket = Array.new()
      if data.count > 2
        build_buckets(data)
      else
        @mainBucket = bubble_sort(data)
        @mainBucket.each do |var|
            print var
        end
        return
      end
      
      @sortingThread = Thread.new{thread_handler}
      watchdogThread = Thread.new{watchdog(time)}
      
      @sortingThread.abort_on_exception = true
      @sortingThread.join
      watchdogThread.join
      
      if @sortingThread == "dead"
        Thread.list.each{|t| Thread.kill(t)}
      end
      
      @mainBucket.each do |var|
          print var
      end
    end

    #Contract MContracts::TimeLimitNotNil => C::None
    def watchdog(time)
      # task timer
      # ends process if watchdog value is passed
      # watchdog value represented in seconds
      # pre       time_limit
      sleep time
      if @sortingThread.alive?
        Thread.kill(sortingThread)
      end
    end

    #Contract C::Num => C::None
    def build_buckets(data)
      # main function, goal is to build buckets using data
      # each initial bucket has 2 data points
      # pre       data loaded
      # post      bucket containing data
      dataclone = data.clone
      while dataclone.length > 1 do
          @mainBucket.push(dataclone.shift(2))
      end
      
      # Handles the exception if there is an odd number of values in the dataset.
      if dataclone.length == 1
          @mainBucket.pushArray.new(dataclone.shift)
      end
    end

    def thread_handler
      # given initial data input, handles thread operations with thread_sort and combine_bucket
      # pre       data
      # post      completed thread operation
      
      while @mainBucket.count != 1
        # Sort sub buckets in main bucket.
        threads = Array.new
        (0..(@mainBucket.count-1)).each do |rank|
          threads << Thread.new do
            thread_sort(rank)
          end
        end
                  
        # ref http://stackoverflow.com/questions/9095316/handling-exceptions-raised-in-a-ruby-thread
        threads.each(&:join)
      
        # combine sub buckets
        threads = Array.new
        @threadBuckets = Array.new()
        (0..(@mainBucket.count/2).floor-1).each do |rank|
          threads << Thread.new do
            combine_bucket(rank)
          end
        end
      
        threads.each(&:join)
        if @mainBucket.count % 2 == 1
            @threadBuckets.push(@mainBucket.last)
        end
        @mainBucket = @threadBuckets
      end
    end

    #Contract C::Num => C::None
    def thread_sort(rank)
      # thread sort operations parsed here
      # Exceptions: thread-based exceptions
      # pre       data
      # post      sorted data
    
      # sort sub bucket.
      subBucket = @mainBucket[rank]
      bubble_sort(@mainBucket[rank])
    
      # write bucket back to @mainBucket
      $semaphore.lock
        @mainBucket[rank] = subBucket
      $semaphore.unlock
    end
    
    #Contract C::Num => C::None
    def combine_bucket(rank)
      # combines bucket with another bucket
      # combines data, then performs thread_sort again
      # pre       two sorted buckets
      # post      single sorted bucket
      
      # combine buckets
      combinedBucket = merge_sorted_arrays(@mainBucket[2*rank], @mainBucket[(2*rank)+1])
      
      # Write combined bucket to bucket list
      $semaphore.lock
        @threadBuckets.push(combinedBucket)
      $semaphore.unlock
    end
    
    #Contract C::ArrayOf[C::Num] => C::Any
    def bubble_sort(array)
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
    
    #Contract C::ArrayOf[C::Num], C::ArrayOf[C::Num] => C::ArrayOf[C::Num]
    def merge_sorted_arrays(array1, array2)
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
