module Multisort
  module Print
    include Contracts::Core
    C = Contracts

    Contract String => C::Any
    def write_to_file(filepath)
      # writes data to file
      # only usable if @primitive = true
      # exceptions  bad file path, wrong input method
      # pre         filepath
      #             primitive = true

      MContracts::ValidFilePath
      MContracts::ValidFilePermissions
      MContracts::DataPresent

      File.open(filepath, "w") do |f|
        @data.each { |element| 
          f.write(element)
          f.write(", ")
        }
      end
    end

    Contract MContracts::DataPresent => C::Any
    def print_data
      # returns data to console
      # lets users access array
      @data.each { |element| 
        print element
        print ", "
      }
      return
    end 

  end # Print
end # Multisort
