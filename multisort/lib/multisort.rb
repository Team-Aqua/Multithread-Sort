require "multisort/version"
require "contracts"
require "multisort/mcontracts"
require "multisort/io"
require "multisort/sorter"
require "thread"
require 'facter'

module Multisort
  include IO
  include Sorter
  include Contracts::Core
  C = Contracts

  def self.sort(input, timer, threadNum: nil, outputfile: nil)
    data = nil

    #Input
    if input.is_a?(Array)
      MContracts::NilArray.valid?(input)
      data = input
    elsif input.is_a?(String)
      data = Multisort::IO::load_from_file(input)
    else
      raise RuntimeError.new, "Input invalid must be Array or filename"
    end

    #Timer
    MContracts::IsTimerNumeric.valid?(timer)

    #Threads
    if threadNum == nil 
      threadNum = Facter.value('processors')['count']
      if threadNum == nil
        threadNum = 2
      end
    else
      MContracts::IsThreadNumInteger.valid?(threadNum)
      if threadNum > (data.count/2).floor
        threadNum = (data.count/2).floor
      end
    end

    MContracts::IsComparable.valid?(data)
    MContracts::ArrayElementsEqualClass.valid?(data)

    data = Multisort::Sorter::main_sort(data, threadNum, timer)

    #Output
    if outputfile == nil
      return data
    else
      return Multisort::IO::write_to_file(data, outputfile)
    end
  end
end