require_relative '../lib/redbubble/input_helper'

class TestInputHelper < MiniTest::Test
  def test_input_helper_unit_with_no_ARGV
    input_helper = Redbubble::InputHelper.new([])
    assert_raises(NoArgumentsPassed) { input_helper.validate_argv! }
  end

  def test_input_helper_unit_with_wrong_number_of_ARGV
    [
      ["1"],
      ["1", "2", "3"],
      ["abc", "45678", "dfgfdgfgffdgdfg", "some more", "yadi yadi yada"]
    ].each do |bad_argv|
      assert_raises(WrongNoOfArgs) { Redbubble::InputHelper.new(bad_argv).validate_argv! }
    end
  end

  def test_input_helper_with_valid_ARGV
    input_helper = Redbubble::InputHelper.new(["/Users/John/some_file.xml", "/www/output_dir"])
    assert_equal ["/Users/John/some_file.xml", "/www/output_dir"], input_helper.validate_argv!
  end
end
