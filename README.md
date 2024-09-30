# WatermarkToPdf

`WatermarkToPdf` is a Ruby gem that allows you to easily add text-based watermarks to PDF files. It leverages `MiniMagick` for manipulating images and `ImageMagick` for processing PDF pages into images, applying the watermark, and converting them back into a PDF.

## Installation

To install the gem and add it to your application's Gemfile, execute:

```bash
$ bundle add watermark_to_pdf
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
$ gem install watermark_to_pdf
```

## Prerequisites

Ensure you have `ImageMagick` installed on your system. Use the following commands based on your OS:

For macOS:

```bash
$ brew install imagemagick
```

For Linux:

```bash
$ sudo apt-get install imagemagick
```

You will also need the following Ruby gem to manipulate PDFs:

```bash
$ gem install mini_magick
```

## Usage

To add a watermark to a PDF file, use the WatermarkToPdf module as follows:

```bash
require 'watermark_to_pdf'

file = File.open('path_to_your_pdf_file.pdf')

options = {
  texts: [
    {
      text: "Confidential",
      position: [0, 0],   # Offset from the center (x, y)
      size: 150,          # Font size
      color: "rgba(255, 0, 0, 0.3)", # Red with transparency
      font: "Helvetica-Bold",
      weight: 700         # Font weight
    }
  ]
}

# Add the watermark to the PDF
watermarked_pdf = WatermarkToPdf.add_watermark(file, options)

# Save the watermarked PDF to a desired location
FileUtils.mv(watermarked_pdf, 'path_to_save_watermarked_pdf.pdf')
```

## Customization Options

The `options` hash allows you to customize the watermark by providing an array of texts with the following options:

- **text**: The text to display as a watermark.
- **position**: An array `[x, y]` that defines the position offset from the center of the page.
- **size**: The font size of the watermark text.
- **color**: The color of the watermark text in `rgba` format (e.g., `rgba(128, 128, 128, 0.5)` for a semi-transparent gray).
- **font**: The font family for the watermark text (default is `Helvetica-Oblique`).
- **weight**: The font weight (e.g., 700 for bold).

You can specify multiple texts with different positions and styles.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/[Junaid0118]/watermark_to_pdf](https://github.com/Junaid0118/watermark_to_pdf). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Junaid0118/watermark_to_pdf/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


