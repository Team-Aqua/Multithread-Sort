require "filewatcher/mcontracts"
module Multisort
  module Print

    include Contracts::Core
    C = Contracts

    Contract C::And[MContracts::ValidFilePath, MContracts::ValidFilePermissions, MContracts::DataPresent] => C::None
    def write_to_file(filepath)
      # writes data to file
      # only usable if @primitive = true
      # exceptions  bad file path, wrong input method
      # pre         filepath
      #             primitive = true
    end

    Contract MContracts::DataPresent => C::None
    def print
      # returns data to console
      # lets users access array
    end 

  end # Print
end # Multisort
