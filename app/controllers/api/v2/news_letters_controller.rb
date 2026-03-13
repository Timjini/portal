# frozen_string_literal: true

module Api
  module V2
    class NewsLettersController < Api::V1::BaseController
      skip_forgery_protection only: [:create]
      skip_before_action :authenticate_user!

      def create
        news_letter = NewsLetter.create!(news_letter_params)
        if news_letter.save
          render json: { status: 'success', message: 'Welcome to the inner circle' },
                 status: :created
        else
          render json: { status: 'error', message: form.errors.full_messages }, status: :unprocessable_content
        end
      end

      def news_letter_params
        params.except(:news_letter).permit(:email, :name)
      end
    end
  end
end
