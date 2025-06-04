# frozen_string_literal: true

# app/utils/save_attachment_to_public.rb

class SaveAttachmentToPublic
  def self.call(attachment) # rubocop:disable Metrics/MethodLength
    return unless attachment.respond_to?(:read)

    attachments_dir = Rails.public_path.join('uploads')
    FileUtils.mkdir_p(attachments_dir)
    filename = "#{SecureRandom.uuid}#{File.extname(attachment.original_filename)}"
    file_path = attachments_dir.join(filename)

    begin
      File.binwrite(file_path, attachment.read)
      Rails.logger.info "File saved successfully: #{file_path}"
      file_path.to_s
    rescue StandardError => e
      Rails.logger.error "Error saving attachment: #{e.message}"
      nil
    end
  end
end
