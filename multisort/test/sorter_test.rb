require "minitest/autorun"
require "multisort"
require "multisort/sorter"

class TestComparatorObject
  include Comparable
  attr_reader :value

  def initialize(val)
    @value = val
  end
  def <=> (other) 
    @value <=> other.value
  end
end

class SorterTest < Minitest::Test
  include Multisort::Sorter
    
  def setup
  end

  def test_sort
    assert  [1,2,2,3] == Multisort.sort([2,1,2,3], 20, threadNum: 2)
    assert  [1,2,2,3,3,4,5] == Multisort.sort([2,1,3,4,5,3,2], 20, threadNum: 3)
    assert  [1,2,2,3,3,4,4,5] == Multisort.sort([2,1,3,4,5,3,2,4], 20, threadNum: 8)

    assert  [1,2] == Multisort.sort([2,1], 20, threadNum: 4)
    assert  [1,2] == Multisort.sort([2,1], 20, threadNum: 8)
    assert  [4,6,8,9,10,10,21,32,53,71] == Multisort.sort("test/test_files/test_csv.csv", 20, threadNum: 8)
    assert  [4.2,6.4,8.8,9.0,10.1,10.2,21.2,32.3,53.3,71.6] == Multisort.sort("test/test_files/test_float_csv.csv", 20)
    
    assert [1,2] == Multisort.sort([1,2], 20, threadNum: 4)
    assert "---\n- 1\n- 2\n" == Multisort.sort([1,2], 20, outputfile: "output.yml")
    assert "---\n- 1\n- 2\n" == Multisort.sort([1,2], 20, threadNum: 4, outputfile: "output.yml")

    assert [1,2] == Multisort.sort([1,2], 2.2, threadNum: 4)
  end

  def test_sort_string
    ["Aaron", "Anson", "Quentin"] == Multisort.sort(["Anson", "Quentin", "Aaron"], 20, threadNum: 5)
  end

  def test_obj_sort
    t1 = TestComparatorObject.new(1)
    t2 = TestComparatorObject.new(2)
    t3 = TestComparatorObject.new(3)

    [t1, t2, t3] == Multisort.sort([t2,t3,t1], 200)
  end
  

  def test_edge_case_brute_force
    
    assert [1] == Multisort.sort([1], 20, threadNum: 1)
    assert [1, 2] == Multisort.sort([2, 1], 20, threadNum: 1)
    assert [1, 2, 3] == Multisort.sort([3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4] == Multisort.sort([4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5] == Multisort.sort([5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6] == Multisort.sort([6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7] == Multisort.sort([7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7, 8] == Multisort.sort([8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9] == Multisort.sort([9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] == Multisort.sort([10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] == Multisort.sort([11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12] == Multisort.sort([12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] == Multisort.sort([13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14] == Multisort.sort([14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15] == Multisort.sort([15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] == Multisort.sort([16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] == Multisort.sort([17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18] == Multisort.sort([18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19] == Multisort.sort([19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20] == Multisort.sort([20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 1)

    assert [1] == Multisort.sort([1], 20, threadNum: 2)
    assert [1, 2] == Multisort.sort([2, 1], 20, threadNum: 2)
    assert [1, 2, 3] == Multisort.sort([3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4] == Multisort.sort([4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5] == Multisort.sort([5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6] == Multisort.sort([6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7] == Multisort.sort([7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7, 8] == Multisort.sort([8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9] == Multisort.sort([9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] == Multisort.sort([10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] == Multisort.sort([11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12] == Multisort.sort([12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] == Multisort.sort([13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14] == Multisort.sort([14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15] == Multisort.sort([15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] == Multisort.sort([16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] == Multisort.sort([17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18] == Multisort.sort([18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19] == Multisort.sort([19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20] == Multisort.sort([20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 2)

    assert [1] == Multisort.sort([1], 20, threadNum: 3)
    assert [1, 2] == Multisort.sort([2, 1], 20, threadNum: 3)
    assert [1, 2, 3] == Multisort.sort([3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4] == Multisort.sort([4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5] == Multisort.sort([5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6] == Multisort.sort([6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7] == Multisort.sort([7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7, 8] == Multisort.sort([8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9] == Multisort.sort([9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] == Multisort.sort([10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] == Multisort.sort([11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12] == Multisort.sort([12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] == Multisort.sort([13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14] == Multisort.sort([14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15] == Multisort.sort([15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] == Multisort.sort([16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] == Multisort.sort([17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18] == Multisort.sort([18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19] == Multisort.sort([19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20] == Multisort.sort([20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 3)

    assert [1] == Multisort.sort([1], 20, threadNum: 4)
    assert [1, 2] == Multisort.sort([2, 1], 20, threadNum: 4)
    assert [1, 2, 3] == Multisort.sort([3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4] == Multisort.sort([4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5] == Multisort.sort([5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6] == Multisort.sort([6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7] == Multisort.sort([7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7, 8] == Multisort.sort([8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9] == Multisort.sort([9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] == Multisort.sort([10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] == Multisort.sort([11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12] == Multisort.sort([12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] == Multisort.sort([13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14] == Multisort.sort([14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15] == Multisort.sort([15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] == Multisort.sort([16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] == Multisort.sort([17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18] == Multisort.sort([18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19] == Multisort.sort([19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20] == Multisort.sort([20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 4)

    assert [1] == Multisort.sort([1], 20, threadNum: 5)
    assert [1, 2] == Multisort.sort([2, 1], 20, threadNum: 5)
    assert [1, 2, 3] == Multisort.sort([3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4] == Multisort.sort([4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5] == Multisort.sort([5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6] == Multisort.sort([6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7] == Multisort.sort([7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7, 8] == Multisort.sort([8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9] == Multisort.sort([9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] == Multisort.sort([10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] == Multisort.sort([11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12] == Multisort.sort([12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] == Multisort.sort([13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14] == Multisort.sort([14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15] == Multisort.sort([15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] == Multisort.sort([16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17] == Multisort.sort([17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18] == Multisort.sort([18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19] == Multisort.sort([19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20] == Multisort.sort([20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 20, threadNum: 5)    
  end

  def test_benchmarks
    # timer { Multisort.sort("test/test_files/extra_large_csv.csv", 200)}
    # data1 = Multisort::IO::load_from_file("test/test_files/extra_large_csv.csv")
    # timer {Multisort::Sorter::bubble_sort(data1)}
  end
  
  def timer
    t = Time.now
    result = yield
    puts "\nCompleted in #{Time.now - t} seconds"
    result
  end
end

