# frozen_string_literal: true

class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)

    if @review.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to athlete_profiles, notice: 'Review added successfully.' } # rubocop:disable Rails/I18nLocaleTexts
      end
    else
      render turbo_stream: turbo_stream.replace('review_form', partial: 'reviews/form', locals: { review: @review })
    end
  end

  private

  def review_params
    params.require(:reviews).permit(:comment, :reviewable_type, :reviewable_id, :coach_id, :user_id)
  end
end
