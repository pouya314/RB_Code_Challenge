# End-to-end system tests go here ...

require 'capybara'
require 'capybara/poltergeist'


# session = Capybara::Session.new(:poltergeist)
# session.visit "file:///Users/arvapo/work/new-dest/index.html"
# session.has_content? "index"
class TestSystemRedbubble < MiniTest::Test
  include Capybara::DSL

  def setup
    Capybara.default_driver = :poltergeist
  end

  def test_123
    valid_xml_input = "#{File.expand_path(File.dirname(__FILE__))}/sample_data/valid_input.xml"
    output_path = "#{File.expand_path(File.dirname(__FILE__))}/sample_output"

    # Dir.chdir "#{File.expand_path("..", Dir.pwd)}" #change directory to root path
    `cd ..`
    `ruby -I lib bin/redbubble #{valid_xml_input} #{output_path}`

    visit "file://#{output_path}/index.html"
    assert page.has_content? "index"
  end
end
