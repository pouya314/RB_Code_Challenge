require 'fileutils'
require_relative '../lib/redbubble/html_generation'
require_relative '../lib/redbubble/input_processing'


class TestHTMLGeneration < MiniTest::Test
  def setup
    @sample_data_folder_path   = "#{File.expand_path(File.dirname(__FILE__))}/sample_data"
    @sample_output_folder_path = "#{File.expand_path(File.dirname(__FILE__))}/sample_output"

    # create the sample output folder if it does not exist.
    # we wanna have a pre-existing folder in place, for some test cases.
    FileUtils.mkdir_p @sample_output_folder_path unless Dir.exist? @sample_output_folder_path
  end

  def teardown
    @sample_data_folder_path   = nil
    @sample_output_folder_path = nil
  end

  def test_html_generation_with_empty_works_collection
    assert_raises(InsufficientWorkData) {Redbubble::HtmlGeneration.new([], @sample_output_folder_path)}
  end

  def test_html_generation_with_invalid_works
    parser = Redbubble::XmlParser.new("#{@sample_data_folder_path}/invalid_input.xml")
    result = parser.parse
    assert_raises(InsufficientWorkData) {Redbubble::HtmlGeneration.new(result, @sample_output_folder_path)}
  end

  def give_me_valid_works_collection
    parser = Redbubble::XmlParser.new("#{@sample_data_folder_path}/valid_input.xml")
    return parser.parse
  end

  def test_html_generation_preps_output_directory_if_not_exist_and_geneartes_files_in_it
    result = give_me_valid_works_collection
    my_new_folder = "#{File.expand_path(File.dirname(__FILE__))}/my_new_folder"
    generation = Redbubble::HtmlGeneration.new(result, my_new_folder)
    generation.go!
    assert Dir.exist? my_new_folder
    Dir.chdir(my_new_folder) do
      assert_equal 14, Dir.glob("*").count
    end
    FileUtils.rm_r my_new_folder
  end

  def test_html_generation_works_with_existing_folder
    result = give_me_valid_works_collection
    generation = Redbubble::HtmlGeneration.new(result, @sample_output_folder_path)
    generation.go!
    Dir.chdir(@sample_output_folder_path) do
      assert_equal 14, Dir.glob("*").count
    end
    FileUtils.rm_r @sample_output_folder_path
    FileUtils.mkdir_p @sample_output_folder_path
  end
end
