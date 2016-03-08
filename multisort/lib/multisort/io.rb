require 'bigdecimal'
require 'yaml'
module Multisort
  module IO
    include Contracts::Core
    C = Contracts

    Contract C::And[C::Or[MContracts::ValidCSV, MContracts::ValidJSON], MContracts::ValidFilePath, MContracts::ValidFilePermissions] => C::Any
    # ignore MContracts::ValidJSON, MContracts::ValidYAML
    def self.load_from_file(filepath)
      # loads data set from file. Checks if filepath is clear, reads data.
      # exceptions  bad file path, bad data read
      # pre         filepath
      # post        data
      #             data_loaded = true
      #             primitive = true
      #             data_type

      MContracts::ValidFilePath.valid?(filepath)
      MContracts::ValidFilePermissions.valid?(filepath)

      data = []
      file = File.new(filepath, "r")
      if (filepath.include? ".csv")
        open(filepath) do |csv|
          csv.each_line do |line|
            values = line.gsub(/\s+/, "").split(",")
            values.each do |value|
              data.push(to_numeric(value))
            end
          end
        end
        MContracts::IsPrimitive.valid?(data.first)
      elsif (filepath.include? ".yml" or filepath.include? ".json")
        yaml = YAML::load_file(File.open(filepath))
        data = YAML::load(yaml)
      else
        file.close
        raise RuntimeError.new, "Invalid Filetype" 
        return false
      end
      file.close
      MContracts::DataPresent.valid?(self)
      return data
    end

    def self.to_numeric(anything)
      num = BigDecimal.new(anything.to_s)
      if num.frac == 0
        num.to_i
      else
        num.to_f
      end
    end

    def self.write_to_file(data, filepath)
      # writes data to file
      # only usable if @primitive = true
      # exceptions  bad file path, wrong input method
      # pre         filepath
      #             primitive = true

      MContracts::ValidFilePath
      MContracts::ValidFilePermissions
      MContracts::DataPresent

      # File.open(filepath, "w") do |f|
      #   f.write("Structure: ")
      #   f.write(@data_type)
      #   f.write("\nArray: [")
      #   @data.each_with_index { |element, index| 
      #     f.write(element)
      #     if index != @data.size - 1
      #       f.write(", ")
      #     end
      #   }
      #   f.write("]")
      # end
      # return nil
      yaml  = data.to_yaml
      File.open(filepath, 'w').write(yaml)
      return yaml
    end

    Contract MContracts::DataPresent => C::Any
    def self.print_data
      # returns data to console
      # lets users access array
      print @data
      return
    end 

  end # Loader
end # Multisort
