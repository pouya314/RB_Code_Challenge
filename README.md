Description
===================
This application creates a set of static HTML files from an XML image data source.

The batch processor takes the location of the input file and the output directory as parameters. It then produces a single HTML file (based on an output template) for each camera make, camera model and also an index.

The index HTML page contains:
- Thumbnail images for the first 10 work
- Navigation that allows the user to browse to all camera makes

Each Camera Make HTML page contains:
- Thumbnail images of the first 10 works for that camera make
- Navigation that allows the user to browse to the index page and to all camera models of that make

Each Camera Model HTML page contains:
- Thumbnail images of all works for that camera make and model
- Navigation that allows the user to browse to the index page and the camera make


Environments
============
This application was developed on Mac OS X, version 10.9.5, however it should run on all Unix-like operating systems.


Dependencies
===================================
You need to have ruby installed on your system before installing and running the application. During development `rbenv` was used to install and manage ruby versions. The specific (local) ruby version used to develop this application was `2.1.2`.

To check your version, run:
`$ rbenv local`

To learn how to install ruby with rbenv visit my blog post here ([here](http://blog.parsalabs.com/blog/2013/08/27/setting-up-a-ruby-on-rails-4-development-environment-on-a-clean-mac-os-x-installation/)). It will show you, step-by-step, how to setup a complete ruby and rails environment on Mac OS X.

You will also need to install bundler by running this in your terminal:
`gem install bundler`

####PhantomJS:
For integration tests to run, you need to have PhantomJS installed on your machine. On a Mac, this can be done with homebrew `brew install phantomjs`. For installation instructions on other platforms, see: http://phantomjs.org/download.html

####Caveat:
While installing PhantomJS, homebrew might update OpenSSL. This made me unable to run `bundle install` anymore. What I did to solve this problem was to rebuild my installation of ruby 2.1.2 (of course through rbenv) and it re-linked against the newly updated SSL.


Installation Instructions
=========================
After cloning the repository to your local development machine, `cd` to the root directory and invoke `$ bundle install`. This will grab all dependencies specified in `Gemfile` and install them. Once this is done, the application is ready to run.


Usage 
=====
To run the application, invoke the following command at the root directory
- `$ ruby -I lib bin/redbubble [input file path goes here] [output directory path goes here]`


Testing Instructions
====================
At the root directory: 
- To run unit tests invoke: `$ ruby test/test_units.rb`
- To run integration tests invoke: `$ ruby test/test_integration.rb`


Code Structure
==============
A quick code walkthrough:
- `bin/redbubble` is the simple launcher of the application that calls the runner.
- `lib/redbubble/runner.rb` is, as its name suggests, the runner of the whole app. Another suitable name for it would be the controller. It's the component that owns all business objects and orchestrates their interaction, in order to get the job done. runner passes ARGV to InputHelper for some validation, then makes use of XMLParser to turn xml to a collection of ruby objects, and finally tells HTMLGeneration to produce the static files in the required location. As a bonus, it also launches system defualt browser, and navigates to the index page generated. Error handling for several exceptions also takes place in the runner. Althuogh all rescue blocks here basically just display the error message and stack trace, their separation is to demonstrate that error handling should be done in a 'specific' manner.
- `lib/redbubble/input_helper.rb`, `lib/redbubble/input_processing.rb` and `lib/redbubble/html_generation.rb` are our business logic objects.
- `lib/redbubble/work.rb` is our data model class.
- `lib/redbubble/errors.rb` contains our app specific exceptions.
- `lib/redbubble/constants.rb` contains constant values.
- inside `lib/redbubble/templates` is where we store our output template. which is used by html_generation to render html files.
- `test/` folder contains our unit & integration tests. all unit test files are included in `test_units.rb` so that they all can be run together. integration tests can be found in `test_integration.rb`.
- `test/sample_data` is the folder that contains sample test data used by our test cases. Similar to fixtures in Rails.

Note: In commit `52ba43e62d07e38393df35e1bc070003bad8ba7d` I explain about an assumption I made while designing the app, and the reasoning behind it.
