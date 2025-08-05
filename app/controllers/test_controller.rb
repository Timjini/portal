class TestController < ApplicationController
  def index
    # render view
  end

  def create
    sleep 2

    respond_to do |format|
      format.html do
        flash[:notice] = "✅ Created at #{Time.now.strftime("%H:%M:%S")}"
        redirect_to test_index_path
      end

      format.json do
        render json: { message: "✅ Created at #{Time.now.strftime("%H:%M:%S")}" }
      end
    end
  rescue => e
    Rails.logger.error "Create failed: #{e.message}"

    respond_to do |format|
      format.html do
        flash[:alert] = "Something went wrong. #{e.message}"
        redirect_to test_index_path
      end

      format.json do
        render json: { message: "Something went wrong." }, status: :unprocessable_entity
      end
    end
  end
end
