module Multisort
  module Loader
    include Contracts::Core
    C = Contracts

    Contract C::And[C::Or[MContracts::ValidCSV, MContracts::ValidJSON], MContracts::ValidFilePath, MContracts::ValidFilePermissions] => C::None
    # ignore MContracts::ValidJSON, MContracts::ValidYAML
    def load_from_file(filepath)
      # loads data set from file. Checks if filepath is clear, reads data.
      # exceptions  bad file path, bad data read
      # pre         filepath
      # post        data
      #             data_loaded = true
      #             primitive = true
      #             data_type

      MContracts::ValidFilePath(filepath)
      MContracts::ValidFilePermissions(filepath)

      file = File.new(filepath, "r")

      if (filepath.include? ".csv")
        open(filename) do |csv|
          csv.each_line do |line|
            values = line.gsub(/\s+/, "").split(",")
            values.each do |value|
              @data.push(value)
            end
          end
        end
        @data_loaded = true
      elsif (filepath.include? ".json")
        @data_loaded = true
      else
        file.close
        raise RuntimeError.new, "Invalid Filetype" 
      end
      file.close
      MContracts::DataPresent(self)
      MContracts::IsPrimitive(@data.first)
      return
    end

    Contract MContracts::ArrayElementsEqualClass => C::Any
    def load_from_data(dataset)
      # loads data set from ruby console.
      # pre         dataset
      # post        data
      #             data_loaded = true
      @data = dataset
      @data_loaded = true
      sanitise_data
      return 
    end

    Contract C::And[MContracts::NilArray, MContracts::DataPresent, MContracts::IsComparable, MContracts::ValidArraySize, MContracts::ArrayElementsEqualClass] => C::Bool
    def sanitise_data
      # checks if data is usable for testing.
      # exceptions  too large of array, inconsistent array data type, no comparable for object
      # pre         size_limit
      # post        data_type
      #             primitive (if objects are primitive
      #             data_cleaned
      #             boolean
      
      @data_type = @data.first.class
      @data_cleaned = true;
      return true
    end

  end # Loader
end # Multisort
