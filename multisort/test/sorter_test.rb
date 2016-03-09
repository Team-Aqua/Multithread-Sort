require "minitest/autorun"
require "multisort"
require "multisort/sorter"

class SorterTest < Minitest::Test
  include Multisort::Sorter
    
  def setup
  end

  def test_sort
    # assert  [1,2] == Multisort.sort([2,1], 20)
    assert  [1,2,2,3] == Multisort.sort([2,1,2,3], 20, threadNum: 2)
    assert  [1,2,2,3,3,4,5] == Multisort.sort([2,1,3,4,5,3,2], 20, threadNum: 3)
    assert  [1,2,2,3,3,4,4,5] == Multisort.sort([2,1,3,4,5,3,2,4], 20, threadNum: 8)


    # assert_raises(RuntimeError.new) { Multisort.sort("test/test_files/test_medium_csv.csv", 2) }
    # assert  [1,2] == Multisort.sort([2,1], 20, threadNum: 4)
    # assert  [1,2] == Multisort.sort([2,1], 20, threadNum: 8)
    # assert  [4,6,8,9,10,10,21,32,53,71] == Multisort.sort("test/test_files/test_csv.csv", 20, threadNum: 8)
    # assert  [10.1, 21.2, 32.3, 4.2, 53.3, 6.4, 71.6, 8.8, 9.0, 10.2] == Multisort.sort("test/test_files/test_float_csv.csv", 20)
    
    # assert [1,2] == Multisort.sort([1,2], 20, threadNum: 4)
    # assert "---\n- 1\n- 2\n" == Multisort.sort([1,2], 20, outputfile: "output.yml")
    # assert "---\n- 1\n- 2\n" == Multisort.sort([1,2], 20, threadNum: 4, outputfile: "output.yml")
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
  # def test_failed_main_sort
  #   assert_output("Return error") {main_sort([2, 4, 6, 8, 10, 1, 3, 5, 7, 9], 0)}
  # end
end

