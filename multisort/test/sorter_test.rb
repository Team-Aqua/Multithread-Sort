require "minitest/autorun"
require "multisort"
require "multisort/sorter"

class SorterTest < Minitest::Test
  include Multisort::Sorter
    
  def setup
  end
  
  def test_main_sort
    @ms = Multisort::MSDriver.new
    @ms.load_from_data([2, 4, 6, 8, 10, 1, 3, 5, 7, 9])
    assert_equal(true, @ms.data_loaded)
    @ms.main_sort
    assert_equal(true, @ms.data == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])


    # assert_output("[1, 2, 3, 4, 5, 6, 7, 8, 9]") {main_sort([2, 7, 1, 8, 6, 3, 5, 4, 9], 2)}
    # assert_output("[1, 2]") {main_sort([2, 1], 1)}
    # assert_output("[1]") {main_sort([1], 1)}
    # #assert_output("['Hello', 'World', 'From', 'Aaron']") {main_sort(["Aaron", "World", "Hello", "From"], 2)}
  end
  
  # def test_failed_main_sort
  #   assert_output("Return error") {main_sort([2, 4, 6, 8, 10, 1, 3, 5, 7, 9], 0)}
  # end
end

