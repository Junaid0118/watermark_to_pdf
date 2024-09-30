# frozen_string_literal: true

require "mini_magick"
require "tempfile"

# WatermarkToPdf module adds watermarking functionality to PDF files.
module WatermarkToPdf
  class Error < StandardError; end

  # The Watermark class provides methods to add watermarks to PDF files.
  class Watermark
    DEFAULT_TEXT_OPTIONS = {
      text: "Watermark Text",
      position: [0, 0],
      size: 200,
      color: "rgba(128, 128, 128, 0.2)",
      font: "Helvetica-Oblique",
      weight: 700
    }.freeze

    def initialize(file, options = {})
      @file = file
      @options = default_options.merge(options)
    end

    def add_watermark
      Dir.mktmpdir do |dir|
        temp_file = create_temp_pdf(dir)
        image_paths = convert_pdf_to_images(temp_file, dir)

        watermark_images(image_paths, dir)
        watermarked_pdf_path = convert_images_to_pdf(dir)

        cleanup(temp_file, dir)
        watermarked_pdf_path
      end
    end

    private

    def default_options
      {
        texts: [DEFAULT_TEXT_OPTIONS]
      }
    end

    def create_temp_pdf(dir)
      temp_file = Tempfile.new(["original", ".pdf"], dir)
      temp_file.binmode
      temp_file.write(@file.read)
      temp_file.rewind
      temp_file
    end

    def convert_pdf_to_images(temp_file, dir)
      system("convert -density 300 #{temp_file.path} #{dir}/page_%d.png")
      Dir.glob("#{dir}/page_*.png")
    end

    def watermark_images(image_paths, dir)
      image_paths.each_with_index do |image_path, index|
        image = MiniMagick::Image.open(image_path)
        apply_watermarks_to_image(image, @options[:texts])
        image.write("#{dir}/page_#{index}_watermarked.png")
      end
    end

    def apply_watermarks_to_image(image, texts)
      texts.each do |text_options|
        apply_single_watermark(image, text_options)
      end
    end

    def apply_single_watermark(image, text_options)
      image.combine_options do |c|
        c.fill text_options[:color]
        c.gravity "Center"
        c.pointsize text_options[:size]
        c.font text_options[:font]
        c.weight text_options[:weight]
        c.draw "text #{text_options[:position][0]},#{text_options[:position][1]} '#{text_options[:text]}'"
      end
    end

    def convert_images_to_pdf(dir)
      watermarked_pdf_path = "#{dir}/watermarked.pdf"
      system("convert #{dir}/page_*_watermarked.png #{watermarked_pdf_path}")
      watermarked_pdf_path
    end

    def cleanup(temp_file, dir)
      temp_file.close
      temp_file.unlink
      FileUtils.rm_rf(Dir.glob("#{dir}/page_*.png"))
    end
  end

  def self.add_watermark(file, options = {})
    watermark = Watermark.new(file, options)
    watermark.add_watermark
  end
end
