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

  def test_load_from_csv
    @ms = Multisort::MSDriver.new
    @ms.load_from_file("test/test_files/test_csv.csv")
    assert_equal(true, @ms.data_loaded)
    assert_equal(true, [10, 21, 32, 4, 53, 6, 71, 8, 9, 10] == @ms.data)

    @ms.load_from_file("test/test_files/test_float_csv.csv")
    assert_equal(true, @ms.data_loaded)
    assert_equal(true, [10.1, 21.2, 32.3, 4.2, 53.3, 6.4, 71.6, 8.8, 9.0, 10.2] == @ms.data)
  end

  def test_load_from_yaml
    @ms = Multisort::MSDriver.new
    @ms.load_from_file("test/test_files/test_int_yaml.yml")
    assert_equal(true, @ms.data_loaded)
    assert_equal(true, [10, 21, 32, 4, 53, 6, 71, 8, 9, 10] == @ms.data)

    @ms.load_from_file("test/test_files/test_object_yaml.yml")
    assert_equal(true, @ms.data_loaded)
    # assert_equal(true, [Multisort::MSDriver.new, Multisort::MSDriver.new, Multisort::MSDriver.new] == @ms.data)
  end

  def test_print_data
    @ms = Multisort::MSDriver.new
    @ms.load_from_data([1,2,3,4,5,6,7,8,9,10])
    assert_output("") {@ms.write_to_file("result.txt")}
    assert_output("[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]") {@ms.print_data}
  end

end