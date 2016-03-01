module Multisort
  module Sorter

    # Contract
    def main_sort
      # main sort of process
      # delegation and tasks presented here
      # pre       data_loaded = true
      #           data_cleaned = true
      #           sort_status = false
      #           time_limit
    end

    # Contract
    def watchdog
      # task timer
      # ends process if watchdog value is passed
      # watchdog value represented in seconds
      # pre       time_limit
    end

    # Contract
    def build_buckets(data)
      # main function, goal is to build buckets using data
      # each initial bucket has 2 data points
      # pre       data loaded
      # post      bucket containing data
    end

    def thread_handler(data)
      # given initial data input, handles thread operations with thread_sort and combine_bucket
      # pre       data
      # post      completed thread operation
    end

    # Contract
    def thread_sort
      # thread sort operations parsed here
      # Exceptions: thread-based exceptions
      # pre       data
      # post      sorted data
    end

    # Contract
    def combine_bucket(thread)
      # combines bucket with another bucket
      # combines data, then performs thread_sort again
      # pre       two sorted buckets
      # post      single sorted bucket
    end

  end # Sorter
end # Multisort
