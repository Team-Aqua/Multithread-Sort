require "minitest/autorun"
require "multisort"
require "multisort/mcontracts"

class MPropertiesTest < Minitest::Test

  def test_if_data_primitive
    @ms = Multisort::MSDriver.new
    @ms.load_from_data([1,2,3,4,5,6,7,8,9,10])
    assert @ms.is_data_primitive?

    # @ms_array = Multisort::MSDriver.new
    # @ms_array.load_from_data([Array.new])
    # assert_raises RuntimeError.new { @ms_array.is_data_primitive? }
  end


end