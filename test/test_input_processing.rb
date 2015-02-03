require 'fileutils'
require_relative '../lib/redbubble/input_processing'
require_relative '../lib/redbubble/work'
require 'nokogiri'

class TestInputProcessing < MiniTest::Test
  def setup
    @sample_data_folder_path = File.join(File.expand_path(File.dirname(__FILE__)), "sample_data")
  end

  def teardown
    @sample_data_folder_path = nil
  end

  def test_input_processing_with_a_file_that_does_not_exist
    assert_raises(InputFileDoesNotExist) {Redbubble::XmlParser.new(File.join(@sample_data_folder_path, "kjhfjkdshfdjkfh.txt"))}
  end

  def test_input_processing_with_a_xml_file_which_is_empty
    assert_raises(FileEmpty) {Redbubble::XmlParser.new(File.join(@sample_data_folder_path, "emptyfile.xml"))}
  end

  def test_input_processing_with_a_non_xml_file
    assert_raises(FileNotXML) {Redbubble::XmlParser.new(File.join(@sample_data_folder_path, "some.html"))}
  end

  def test_input_processing_with_yet_another_non_xml_file
    assert_raises(FileNotXML) {Redbubble::XmlParser.new(File.join(@sample_data_folder_path, "some.txt"))}
  end

  def test_input_processing_with_a_xml_file_which_is_badly_formed
    assert_raises(Nokogiri::XML::SyntaxError) {Redbubble::XmlParser.new(File.join(@sample_data_folder_path, "badly_formed.xml"))}
  end

  def test_input_processing_with_a_valid_input
    parser = Redbubble::XmlParser.new(File.join(@sample_data_folder_path, "valid_input.xml"))
    result = parser.parse
    assert_kind_of Array, result
    result.each do |item|
      assert_instance_of Redbubble::Work, item
      assert_respond_to item, :invalid?
    end
  end
end
