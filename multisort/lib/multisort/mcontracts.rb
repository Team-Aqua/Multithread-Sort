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

    class ValidYAML
      def self.valid? args
        return false
      end
      def self.to_s
        "TODO"
      end
    end

    class ValidJSON
      def self.valid? args
        return false
      end
      def self.to_s
        "TODO"
      end
    end

    class NilArray
      def self.valid? array
        if array == nil or array == "" or array == []
          return false
        end
        return true
      end
      def self.to_s
        "TODO"
      end
    end

    class ArrayElementsEqualClass
      def self.valid? array
        array.each do |element|
          if !element.is_a?(array[0].class)
            return false
          end
        end
        return true
      end
      def self.to_s
        "TODO"
      end
    end

    class ValidYAML
      def self.valid? args
        return false
      end
      def self.to_s
        "TODO"
      end
    end

    class IsComparable
      def self.valid? obj
        if obj.respond_to?(:<=>)
          return true
        end
        return false
      end
    end

    class ValidFilePermissions
      def self.valid? filename
        #File.chmod(0644, filename)   #=> 1
        stats = File.stat(filename)
        # sprintf("%o", stats.mode)          #=> "100644"
        if stats.mode != "100644"
          return false
        end
        return true
      end
    end

    class ValidFilePath
      def self.valid? filepath
        File.stat(filepath).file?
      end
    end

  end
end