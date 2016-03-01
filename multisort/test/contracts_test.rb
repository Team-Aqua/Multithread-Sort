require "minitest/autorun"
require "multisort"
require "multisort/mcontracts"

class MContractsTest < Minitest::Test

  class Foo
  end

  # class <<Foo
  #   remove_method :<=>
  # end

  def test_argument_validation
    assert !MultiSort::MContracts::argument_validation(Array.new,[MultiSort::MContracts::NilArray])
    assert MultiSort::MContracts::argument_validation([1, 1, 1],[MultiSort::MContracts::ArrayElementsEqualClass])
    assert !MultiSort::MContracts::argument_validation([1, 1, '1'],[MultiSort::MContracts::ArrayElementsEqualClass])
    assert !MultiSort::MContracts::argument_validation([1, 1, Array.new],[MultiSort::MContracts::ArrayElementsEqualClass])
    assert MultiSort::MContracts::argument_validation([Array.new, Array.new, Array.new],[MultiSort::MContracts::ArrayElementsEqualClass])
    assert MultiSort::MContracts::argument_validation(1,[MultiSort::MContracts::IsComparable])
    assert MultiSort::MContracts::argument_validation('a',[MultiSort::MContracts::IsComparable])

  end

  def test_file_permission
    # f1 = File.new("f1.txt", "w")
    
    # stats = File.stat('f1.txt')
    # puts stats.mode
    # assert !MultiSort::MContracts::argument_validation('f1.txt',[MultiSort::MContracts::ValidFilePermissions])
    # File.chmod(0644, 'f1.txt')
    # puts stats.mode
    # assert MultiSort::MContracts::argument_validation('f1.txt',[MultiSort::MContracts::ValidFilePermissions])
    # f1.close
    # f1.delete

  end

end