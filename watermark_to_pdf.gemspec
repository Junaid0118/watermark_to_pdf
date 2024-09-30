# frozen_string_literal: true

require_relative "lib/watermark_to_pdf/version"

Gem::Specification.new do |spec|
  spec.name = "watermark_to_pdf"
  spec.version = WatermarkToPdf::VERSION
  spec.authors = ["junaid-dev"]
  spec.email = ["junaidiqbalshah011@gmail.com"]

  spec.summary = "A Ruby gem to add customizable watermarks to PDF files using MiniMagick."
  spec.description = "WatermarkToPdf is a Ruby gem that allows you to add text-based watermarks to PDF files. \
It uses the MiniMagick library to process PDF pages as images, apply customizable watermark text, \
and then converts the watermarked pages back into a single PDF. The gem supports setting different \
watermark text, font, size, position, and color for each page, providing a flexible solution for adding \
professional watermarks to your PDF documents."

  spec.homepage = "https://github.com/Junaid0118/watermark_to_pdf"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = "https://github.com/Junaid0118/watermark_to_pdf"
  spec.metadata["source_code_uri"] = "https://github.com/Junaid0118/watermark_to_pdf"
  spec.metadata["changelog_uri"] = "https://github.com/Junaid0118/watermark_to_pdf/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "mini_magick", "~> 4.11"
  spec.add_runtime_dependency "mini_magick"


  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
