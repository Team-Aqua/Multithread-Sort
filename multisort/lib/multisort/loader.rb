module Multisort
  module Loader

    # Contract
    def load_from_file(filepath)
      # loads data set from file. Checks if filepath is clear, reads data.
      # exceptions  bad file path, bad data read
      # pre         filepath
      # post        data
      #             data_loaded = true
      #             primitive = true
      #             data_type
    end

    # Contract
    def load_from_data(dataset)
      # loads data set from ruby console.
      # pre         dataset
      # post        data
      #             data_loaded = true
    end

    # Contract
    def sanitise_data
      # checks if data is usable for testing.
      # exceptions  too large of array, inconsistent array data type, bad data, no comparable for object
      # pre         size_limit
      # post        data_type
      #             primitive (if objects are primitive
      #             data_cleaned
    end

  end # Loader
end # Multisort
