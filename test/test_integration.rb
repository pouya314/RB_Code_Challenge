# 
# End-to-End System tests using Capybara
# 

require 'minitest/autorun'
require 'capybara'
require 'capybara/poltergeist'


class TestSystemRedbubble < MiniTest::Test

  def setup
    @valid_xml_input  = File.join(File.expand_path(File.dirname(__FILE__)), "sample_data", "valid_input.xml")
    @badly_formed_xml = File.join(File.expand_path(File.dirname(__FILE__)), "sample_data", "badly_formed.xml")
    @output_path      = File.join(File.expand_path(File.dirname(__FILE__)), "sample_output")
    @launcher_path    = File.join(File.expand_path(".", Dir.pwd), "bin", "redbubble")
    @lib_path         = File.join(File.expand_path(".", Dir.pwd), "lib")
    @session          = Capybara::Session.new(:poltergeist)
  end
  
  def teardown
    @session = nil
    FileUtils.rm_r("#{@output_path}")
    FileUtils.mkdir_p("#{@output_path}")
  end

  def test_user_experience_with_a_valid_input
    # simulate a user running the program from command line:
    `ruby -I #{@lib_path} #{@launcher_path} #{@valid_xml_input} #{@output_path}`
    
    Dir.chdir("#{@output_path}") do
      assert_equal 14, Dir.glob("*").count
    end
    
    @session.visit "file://#{@output_path}/index.html"
    
    @session.within("h1") do
      assert @session.has_content? "index"
    end
    
    @session.within("nav") do
      assert @session.has_selector?("a", :count => 6)
      assert @session.has_content? "Panasonic"
      assert @session.has_content? "Canon"
      assert @session.has_content? "FUJIFILM"
    end
    
    @session.within("table") do
      assert @session.has_selector?("img", :count => 10)
    end
    
    @session.click_link('Canon')

    @session.within("h1") do
      assert @session.has_content? "Canon"
    end

    @session.within("nav") do
      assert @session.has_content? "index"
      assert @session.has_content? "Canon EOS 20D"
      assert @session.has_content? "Canon EOS 400D DIGITAL"
    end
    
    @session.within("table") do
      assert @session.has_selector?("img", :count => 2)
    end
    
    @session.click_link('Canon EOS 20D')

    @session.within("nav") do
      assert @session.has_content? "index"
      assert @session.has_content? "Canon"
    end
    
    @session.within("table") do
      assert @session.has_selector?("img", :count => 1)
    end
  end
  
  def test_the_system_when_no_arguments_are_passed
    output = `ruby -I #{@lib_path} #{@launcher_path}`
    assert output =~ /You need to pass in some arguments/
  end
  
  def test_system_run_with_wrong_number_of_arguments
    output = `ruby -I #{@lib_path} #{@launcher_path} 1 2 3`
    assert output =~ /This program expects exactly 2 arguments/
  end
  
  def test_system_run_with_a_badly_formed_xml_as_input
    output = `ruby -I #{@lib_path} #{@launcher_path} #{@badly_formed_xml} #{@output_path}`
    assert output =~ /Premature end of data in tag/
    
    Dir.chdir("#{@output_path}") do
      assert_equal 0, Dir.glob("*").count
    end
  end

  # and so on...
end
