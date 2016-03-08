require "minitest/autorun"
require "multisort"
require "multisort/mcontracts"

class MBuilderTest < Minitest::Test

  def test_load_data
    @ms = Multisort::MSDriver.new
    @ms.load_from_data([1,2,3,4,5,6,7,8,9,10])
    assert_equal(true, @ms.data_loaded)
    assert_equal([1,2,3,4,5,6,7,8,9,10], @ms.data)
  end

  def test_print_data
    @ms = Multisort::MSDriver.new
    @ms.load_from_data([1,2,3,4,5,6,7,8,9,10])
    assert_output("") {@ms.write_to_file("result.txt")}
    assert_output("1, 2, 3, 4, 5, 6, 7, 8, 9, 10, ") {@ms.print_data}
  end

end