require "multisort/version"

module Multisort

  class MSDriver
    # stores loading and processing operations here
    # include Contracts::

    attr_reader :data, :sort_status, :data_loaded, :data_type, :time_limit
    
    def initialize()  
      @data = nil
      @sort_status = false
      @data_loaded = false
      @data_type = nil
      @time_limit = 500
      @primitive = false
    end

    # Contract
    def load_from_file(filepath)
      # loads data set from file. Checks if filepath is clear, reads data.
      # sets data, data_loaded, primitive = true
      # Exceptions: bad file path, bad data read
    end

    # Contract
    def load_from_data(dataset)
      # loads data set from ruby console.
      # sets data, data_loaded, 
    end

    # Contract
    def sanitise_data
      # checks if data is usable for testing.
      # sets data_type, primitive (if objects are primitive)
      # Exceptions: too large of array, inconsistent array data type, bad data, no comparable for object
    end

    # Contract
    def main_sort
      # main sort of process
      # delegation and tasks presented here
    end

    # Contract
    def watchdog
      # task timer
      # ends process if watchdog value is passed
      # watchdog value represented in seconds
    end

    # Contract
    def build_buckets
      # main function, goal is to build buckets using data
      # each initial bucket has 2 data points
    end

    def thread_handler(data)
      # given initial data input, handles thread operations with thread_sort and combine_bucket
    end

    # Contract
    def thread_sort
      # thread sort operations parsed here
      # Exceptions: thread-based exceptions
    end

    # Contract
    def combine_bucket(thread)
      # combines bucket with another bucket
      # combines data, then performs thread_sort again
    end

    # Contract
    def write_to_file(filepath)
      # writes data to file
      # only usable if @primitive = true
      # Exceptions: bad file path, wrong input method
    end

    # Contract
    def print
      # returns data to console
      # lets users access array
    end 

  end

end


