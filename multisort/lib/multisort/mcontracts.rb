module MultiSort
  module MContracts

    def self.argument_validation(args, contracts)
      contracts.each do | contract |
        if !contract.valid? args
          return false
        end
      end
      return true
    end

    class SortData
      def self.valid? args
        if @data_loaded != true or @data_cleaned != true or @time_limit == nil
          raise RuntimeError, "Cannot sort, bad step"
        end
        return true
      end
      def self.to_s
        "Cannot sort, bad step"
      end
    end

    class TimeLimitNotNil
      def self.valid? args
        if @time_limit == nil
          raise RuntimeError, "No time limit"
          return false
        end
        return true
      end
      def self.to_s
        "No time limit"
      end
    end

    class ValidArraySize
      def self.valid? args
        if @data.length >= 100000
          raise RuntimeError, "Too large array presented"
          return false
        end
        return true
      end
      def self.to_s
        "Too large array presented"
      end
    end

    class DataPresent
      def self.valid? args
        if @data == nil
          raise RuntimeError, "No data present"
          return false
        end
        return true
      end
      def self.to_s
        "No data present"
      end
    end

    # dev: parsing YAML contract
    class ValidYAML
      def self.valid? args
        return false
      end
      def self.to_s
        "Invalid YAML structure provided"
      end
    end

    # dev: parsing JSON contract
    class ValidJSON
      def self.valid? args
        return false
      end
      def self.to_s
        "Invalid JSON structure"
      end
    end

    # dev: parsing CSV contract
    class ValidCSV
      def self.valid? args
        return false
      end
      def self.to_s
        "Invalid CSV structure"
      end
    end

    class NilArray
      def self.valid? @data
        if @data == nil or @data == "" or @data == []
          raise RuntimeError, "Nil array structure passed, reached EOF"
          return false
        end
        return true
      end
      def self.to_s
        "Nil array structure passed, reached EOF"
      end
    end

    class ArrayElementsEqualClass
      def self.valid? @data
        @data.each do |element|
          if !element.is_a?(@data[0].class)
            raise TypeError, "Array elements of different class, can't sort"
            return false
          end
        end
        return true
      end
      def self.to_s
        "Array elements of different class, can't sort"
      end
    end

    class IsComparable
      def self.valid? obj
        if obj.respond_to?(:<=>)
          return true
        end
        raise RuntimeError, "Array elements do not have comparable, can't sort"
        return false
      end
      def self.to_s
        "Array elements do not have comparable, can't sort"
      end
    end

    class ValidFilePermissions
      def self.valid? filename
        #File.chmod(0644, filename)   #=> 1
        stats = File.stat(filename)
        # sprintf("%o", stats.mode)          #=> "100644"
        if stats.mode != "100644"
          raise IOError, "Lack permissions to access file"
          return false
        end
        return true
      end
      def self.to_s
        "Lack permissions to access file"
      end
    end

    class ValidFilePath
      def self.valid? filepath
        if !File.stat(filepath).file?
          raise IOError, "Invalid file path issued"
          return false
      end
      def self.to_s
        "Invalid file path issued"
      end
    end

  end
end