module Multisort
  module Loader

    include Contracts::Core
    C = Contracts

    Contract C::And[MContracts::ValidCSV, MContracts::ValidFilePath, MContracts::ValidFilePermissions] => C::None
    # ignore MContracts::ValidJSON, MContracts::ValidYAML
    def load_from_file(filepath)
      # loads data set from file. Checks if filepath is clear, reads data.
      # exceptions  bad file path, bad data read
      # pre         filepath
      # post        data
      #             data_loaded = true
      #             primitive = true
      #             data_type
    end

    Contract C::And[MContracts::ValidArray, MContracts::ArrayElementsEqualClass] => C::None
    def load_from_data(dataset)
      # loads data set from ruby console.
      # pre         dataset
      # post        data
      #             data_loaded = true
    end

    Contract C::And[MContracts::DataPresent, MContracts::IsComparable] => C::Boolean
    def sanitise_data
      # checks if data is usable for testing.
      # exceptions  too large of array, inconsistent array data type, bad data, no comparable for object
      # pre         size_limit
      # post        data_type
      #             primitive (if objects are primitive
      #             data_cleaned
      #             boolean
    end

  end # Loader
end # Multisort
