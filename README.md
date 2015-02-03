DESCRIPTION
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


ENVIRONMENTS
============
This application was developed on Mac OS X, version 10.9.5, however it should run on all Unix-like operating systems.


SYSTEM DEPENDENCIES & CONFIGURATION
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


INSTALLATION INSTRUCTIONS
=========================
After cloning the repository to your local development machine, `cd` to the root directory and invoke `$ bundle install`. This will grab all dependencies specified in `Gemfile` and install them. Once this is done, the application is ready to run.


USAGE 
=====
To run the application, at the root directory, invoke: 
`$ ruby -I lib bin/redbubble [input file path goes here] [output directory path goes here]`


TESTING INSTRUCTIONS
====================
At the root directory: 
- To run unit tests invoke: `$ ruby test/test_units.rb`
- To run integration tests invoke: `$ ruby test/test_integration.rb`
