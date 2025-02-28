# frozen_string_literal: true

class QrCodesController < ApplicationController
  require 'rqrcode'

  def index
    @qr_code = QrCode.new

    @qr_codes = QrCode.all
  end

  def show
    @qr_code = QrCode.find(params[:id])
  end

  def create
    @qr_code = QrCode.new(qr_code_params)
    qr = RQRCode::QRCode.new(@qr_code.data, size: 10, level: :h)

    # Generate the QR code image and attach it using Active Storage
    @qr_code.image.attach(io: StringIO.new(qr.as_png.resize(300, 300).to_s), filename: 'qr_code.png',
                          content_type: 'image/png')

    if @qr_code.save
      # Handle successful creation
    else
      # Handle validation errors or other failure cases
    end
  end

  def scanner; end

  private

  def qr_code_params
    params.require(:qr_code).permit(:user_id, :data, :scanned)
  end
end
