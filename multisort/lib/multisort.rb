require "multisort/version"
require "contracts"
require "multisort/mcontracts"
require "multisort/loader"
require "multisort/print"
require "multisort/sorter"
require "thread"

module Multisort
  # include Contracts::Core
  # include Contracts::Invariants
  # include Multisort::MContracts
  # include Multisort::Sorter
class MSDriver
  # stores loading and processing operations here
  include Contracts::Core
  include Contracts::Invariants
  include Multisort::Print 
  include Multisort::Loader
  include Multisort::Sorter
  include Multisort::MContracts


  invariant(@time_limit) { @time_limit >= 0}
  invariant(@size_limit) { @size_limit >= 0}

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

  def is_data_primitive?
    if MContracts::DataPresent.valid?(self)
      if MContracts::IsPrimitive.valid?(@data[0])
        return true
      end
    end
    return false
  end

end


end