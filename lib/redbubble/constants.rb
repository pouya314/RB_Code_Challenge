# program constants go here ...
OUTPUT_TEMPLATE       = "#{File.expand_path(File.dirname(__FILE__))}/templates/output-template.eruby"
OUTPUT_PROTOCOL       = "file://"
OUTPUT_FILE_EXTENSION = ".html"


INDEX = {
  :file_name => "index.html",
  :title     => "index"
}


VALID_INPUT_FILE_TYPE = "application/xml"


NOKOGIRI = {
  :css => {
    :access_work_nodes     => "work",
    :access_work_thumb_url => "urls url[type='small']",
    :access_work_make      => "exif make",
    :access_work_model     => "exif model"
  }
  
  # :xpath => {
  #   # ...
  # }
}


ERRORS = {
  # launchy
  :launchy_failed => "Launchy tried but failed to open your default browser. Please open the index.html file which can be found in the output directory you specified.",

  # input helper errors
  :no_arguments_passed                  => "You need to pass in some arguments.",
  :wrong_number_of_arguments            => "This program expects exactly 2 arguments.",
  :input_file_does_not_exist            => "Input file you specified does NOT exist.",
  :output_dir_did_not_exist_but_created => "The output directory path you specified did not exist, but we created it for you.",
  
  # xml parser
  :file_not_xml => "Input file must be of type XML."
}
