require "minitest/autorun"
require "multisort"
require "multisort/mcontracts"

class MContractsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Multisort::VERSION
  end

  class Foo
  end

  # class <<Foo
  #   remove_method :<=>
  # end

  def test_argument_validation
    # assert !Multisort::MContracts::argument_validation(Array.new,[Multisort::MContracts::NilArray])
    # assert Multisort::MContracts::argument_validation([1, 1, 1],[Multisort::MContracts::ArrayElementsEqualClass])
    # assert !Multisort::MContracts::argument_validation([1, 1, '1'],[Multisort::MContracts::ArrayElementsEqualClass])
    # assert !Multisort::MContracts::argument_validation([1, 1, Array.new],[Multisort::MContracts::ArrayElementsEqualClass])
    # assert Multisort::MContracts::argument_validation([Array.new, Array.new, Array.new],[Multisort::MContracts::ArrayElementsEqualClass])
    # assert Multisort::MContracts::argument_validation(1,[Multisort::MContracts::IsComparable])
    # assert Multisort::MContracts::argument_validation('a',[Multisort::MContracts::IsComparable])

  end

  def test_file_permission
    # f1 = File.new("f1.txt", "w")
    
    # stats = File.stat('f1.txt')
    # puts stats.mode
    # assert !Multisort::MContracts::argument_validation('f1.txt',[Multisort::MContracts::ValidFilePermissions])
    # File.chmod(0644, 'f1.txt')
    # puts stats.mode
    # assert Multisort::MContracts::argument_validation('f1.txt',[Multisort::MContracts::ValidFilePermissions])
    # f1.close
    # f1.delete

  end

end