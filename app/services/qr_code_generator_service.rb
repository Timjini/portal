# frozen_string_literal: true

require 'rqrcode'

module QrCodeGeneratorService
  module_function

  def call(record, url)
    qrcode = RQRCode::QRCode.new(url)
    img = qr_code_png_params(qrcode)
    record.qr_code.attach(io: StringIO.new(img.to_s), filename: "qr_code_#{record.id}.png",
                          content_type: 'image/png')
  end

  def qr_code_png_params(qrcode) # rubocop:disable Metrics/MethodLength
    qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120
    )
  end
end
