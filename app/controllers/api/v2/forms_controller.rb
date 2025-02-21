# frozen_string_literal: true

module Api
  module V2
    class FormsController < Api::V1::BaseController
      skip_forgery_protection only: [:create]
      before_action :set_form, only: [:show, :destroy]
      skip_before_action :authenticate_user!

      def index
        begin
          forms = Form.where(title: params[:title], status: "new")
          puts "========> forms #{forms.inspect}"

          if forms.empty?
            return render json: { status: 'error', message: "No entries found" }, status: :not_found
          end

           render json: forms, each_serializer: Api::V2::FormSerializer, status: :ok
        rescue StandardError => e
          render json: { status: 'error', message: "Something went wrong: #{e.message}" }, status: :internal_server_error
        end
      end

      def show
        render json: { status: 'success', data: @form }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { status: 'error', message: "Form not found" }, status: :not_found
      end

      def create
        form = Form.new(form_params)
        if form.save
          begin 
            FormMailer.contact_form_submission(form).deliver_now
          rescue StandardError => e
            puts "----->issues#{e.message}"
          end
          render json: { status: 'success', data: Api::V2::FormSerializer.new(form).serializable_hash }, status: :created
        else
          render json: { status: 'error', message: form.errors.full_messages }, status: :unprocessable_entity
        end
      rescue StandardError => e
        render json: { status: 'error', message: "Something went wrong: #{e.message}" }, status: :internal_server_error
      end

      def destroy
        @form.destroy
        render json: { status: 'success', message: "Form deleted successfully" }, status: :ok
      rescue StandardError => e
        render json: { status: 'error', message: "Something went wrong: #{e.message}" }, status: :internal_server_error
      end

      private

      def set_form
        @form = Form.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { status: 'error', message: "Form not found" }, status: :not_found
      end

      def form_params
        params.require(:form).permit(:email, :title, :name, :phone, :subject, :status, :message)
      end
    end
  end
end
