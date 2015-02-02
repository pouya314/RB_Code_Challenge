require 'erubis'
require_relative 'settings'

module Redbubble
  class HtmlGeneration
    attr_accessor :works, :output_dir_path, :output_template

    def initialize(works, output_dir_path)
      @works = works.delete_if { |work| work.invalid? }  # sanitization of works happens here!
      @output_dir_path = output_dir_path
      @output_template = Erubis::Eruby.new(File.read(OUTPUT_TEMPLATE))
    end

    def go!
      # start with index
      produce_index_page(works)
    end

    private
      def produce_index_page(works)
        makes = works.group_by { |work| work.make_name}

        create_html_file(
          INDEX[:file_name],
          INDEX[:title],
          makes.keys,
          works.take(10).map { |work| work.url }
        )

        # next: pages for makes
        produce_makes_pages(makes)
      end

      def produce_makes_pages(makes)
        makes.each do |make, items|
          models = items.group_by { |item| item.model_name }

          create_html_file(
            "#{make}.html",
            "#{make}",
            models.keys.unshift(INDEX[:title]),
            items.take(10).map { |i| i.url }
          )

          # finally: pages for models
          produce_models_pages(models, make)
        end
      end

      def produce_models_pages(models, make_backref)
        models.each do |model, items|
          create_html_file(
            "#{model}.html",
            "#{model}",
            [INDEX[:title], make_backref],
            items.map { |i| i.url }    # show all here, not the first 10
          )
        end
      end

      def create_html_file(filename, title, nav, thumbnails)
        File.open("#{output_dir_path}/#{filename}", "w") do |f|
          f.puts output_template.result(
            :title      => title,
            :navigation => nav,
            :thumbnails => thumbnails.each_slice(5).to_a
          )
        end
      end
  end
end
