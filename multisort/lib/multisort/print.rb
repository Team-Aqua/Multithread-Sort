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
        f.write("Structure: ")
        f.write(@data_type)
        f.write("\nArray: [")
        @data.each_with_index { |element, index| 
          f.write(element)
          if index != @data.size - 1
            f.write(", ")
          end
        }
        f.write("]")
      end
      return nil
    end

    Contract MContracts::DataPresent => C::Any
    def print_data
      # returns data to console
      # lets users access array
      print @data
      return
    end 

  end # Print
end # Multisort
