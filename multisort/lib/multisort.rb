require "multisort/loader"
require "multisort/print"
require "multisort/thread"
require "multisort/version"

module Multisort

  class MSDriver
    # stores loading and processing operations here
    # include Contracts::
    include Multisort::Loader
    include Multisort::Print 
    include Multisort::Sorter 
    include Multisort::MContracts

    attr_reader :data, :time_limit, :size_limit, :sort_status, :data_loaded, :data_cleaned, :data_type, :primitive
    
    def initialize()  
      @data = nil
      @sort_status = false
      @data_loaded = false
      @data_cleaned = false
      @data_type = nil
      @time_limit = 500 # arbitrary time limit set to 500s
      @size_limit = 25000 # arbitrary size limit set to 25000
      @primitive = false # discern the type of object sorted
    end

  end

end


