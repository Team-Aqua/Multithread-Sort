require 'bigdecimal'
require 'yaml'
module Multisort
  module IO
    include Contracts::Core
    C = Contracts

    Contract C::And[MContracts::ValidFilePath, MContracts::ValidFilePermissions, C::Or[MContracts::ValidCSV, MContracts::ValidYAML]] => C::Any
    def self.load_from_file(filepath)
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
        MContracts::IsNumeric.valid?(data.first)
      elsif (filepath.include? ".yml")
        yaml = YAML::load_file(File.open(filepath))
        data = YAML::load(yaml)
      else
        file.close
        raise RuntimeError.new, "Invalid Filetype" 
        return false
      end
      file.close
      MContracts::DataPresent.valid?(data)
      return data
    end

    def self.to_numeric(anything)
      if anything.include?(".")
        anything.to_f
      else
        anything.to_i
      end
    end

    Contract MContracts::DataPresent, MContracts::ValidFileName => C::Any
    def self.write_to_file(data, filepath)
      yaml  = data.to_yaml
      File.open(filepath, 'w').write(yaml)
      return yaml
    end

    Contract MContracts::DataPresent => C::Any
    def self.print_data(data)
      print data
      return
    end 

  end # Loader
end # Multisort
