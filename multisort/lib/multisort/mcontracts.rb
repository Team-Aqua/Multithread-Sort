require 'csvlint'
module Multisort
  module MContracts

    def self.argument_validation(args, contracts)
      contracts.each do | contract |
        if !contract.valid? args
          return false
        end
      end
      return true
    end

    class String
      def self.valid? args
        return args.is_a?(String)
      end
      def self.to_s
        ""
      end
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
      def self.valid? data
        if data == nil or data == []
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
      def self.valid? filename
        begin
          YAML.load(filename)
        rescue Exception => e
          return false
        end
        return true
      end
      def self.to_s
        "Invalid YAML structure provided"
      end
    end

    # dev: parsing CSV contract
    class ValidCSV
      def self.valid? filename
        validator = Csvlint::Validator.new( File.new(filename))
        return validator.valid?
      end
      def self.to_s
        "Invalid CSV structure"
      end
    end

    class IsTimerNumeric
      def self.valid? data
        if data.is_a?(Numeric)
          return true
        end
        raise RuntimeError, "Timer is not numeric"
        return false
      end
      def self.to_s
        "Data is not numeric"
      end
    end

    class IsThreadNumInteger
      def self.valid? data
        if data.is_a?(Integer)
          return true
        end
        raise RuntimeError, "Thread Num provided is not an integer"
        return false
      end
      def self.to_s
        "Thread Num provided is not an integer"
      end
    end
    class IsNumeric
      def self.valid? data
        if data.is_a?(Numeric)
          return true
        end
        raise RuntimeError, "Data is not numeric"
        return false
      end
      def self.to_s
        "Data is not numeric"
      end
    end

    class NilArray
      def self.valid? data
        if data == nil or data == "" or data == []
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
      def self.valid? data
        data.each do |element|
          if !element.is_a?(data[0].class)

            puts data[0].class
            puts element.class
            puts element
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
        return File.stat(filename).readable?
      end
      def self.to_s
        "Lack permissions to access file"
      end
    end

    class ValidFileName
      def self.valid? filename
        if filename.match(/^.*(\\|\/)/)
          return false
        end
        if filename.match(/[^0-9A-Za-z.\-]/)
          return false
        end
        return true
      end
      def self.to_s
        ""
      end
    end

    class ValidFilePath
      def self.valid? filepath
        if !File.stat(filepath).file?
          raise IOError, "Invalid file path issued"
          return false
        end
        return true
      end
      def self.to_s
        "Invalid file path issued"
      end
    end

  end
end