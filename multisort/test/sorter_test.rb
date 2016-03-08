require "minitest/autorun"
require "multisort"
require "multisort/sorter"

class SorterTest < Minitest::Test
  include Multisort::Sorter
    
  def setup
  end

  def test_sort
    assert  [1,2] == Multisort.sort([1,2], 20)
    assert  [10,21,32,4,53,6,71,8,9,10] == Multisort.sort("test/test_files/test_csv.csv", 20)
    assert  [10.1, 21.2, 32.3, 4.2, 53.3, 6.4, 71.6, 8.8, 9.0, 10.2] == Multisort.sort("test/test_files/test_float_csv.csv", 20)
    
    assert [1,2] == Multisort.sort([1,2], 20, threadNum: 4)
    assert "---\n- 1\n- 2\n" == Multisort.sort([1,2], 20, outputfile: "output.yml")
    assert "---\n- 1\n- 2\n" == Multisort.sort([1,2], 20, threadNum: 4, outputfile: "output.yml")
  end
  
  def test_sort_int
    # @ms = Multisort::MSDriver.new
    # @ms.load_from_data([2, 4, 6, 8, 10, 1, 3, 5, 7, 9])
    # assert_equal(true, @ms.data_loaded)
    # @ms.main_sort
    # assert_equal(true, @ms.data == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

    # @ms.load_from_data([10, 1])
    # assert_equal(true, @ms.data_loaded)
    # @ms.main_sort
    # assert_equal(true, @ms.data == [1, 10])

    # @ms.load_from_data([1])
    # assert_equal(true, @ms.data_loaded)
    # @ms.main_sort
    # assert_equal(true, @ms.data == [1])
  end

  def test_sort_string
    # @ms = Multisort::MSDriver.new
    # @ms.load_from_data(["Anson", "Quentin", "Aaron"])
    # assert_equal(true, @ms.data_loaded)
    # @ms.main_sort
    # assert_equal(true, @ms.data == ["Aaron", "Anson", "Quentin"])
  end

  def test_benchmarks
    # @ms = Multisort::MSDriver.new
    # @ms.load_from_file("test/test_files/extra_large_csv.csv")
    # assert_equal(true, @ms.data_loaded)
    # timer {@ms.main_sort}
    # @ms.load_from_file("test/test_files/extra_large_csv.csv")
    # timer {@ms.bubble_sort(@ms.data)}
  end
  
  def timer
    t = Time.now
    result = yield
    puts "\nCompleted in #{Time.now - t} seconds"
    result
  end
  # def test_failed_main_sort
  #   assert_output("Return error") {main_sort([2, 4, 6, 8, 10, 1, 3, 5, 7, 9], 0)}
  # end
end

