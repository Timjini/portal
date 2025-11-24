# frozen_string_literal: true

class ReviewsController < ApplicationController
  def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    Rails.logger.debug { "params here =======>, #{params.inspect}" }
    @review = Review.new(review_params)
    @level = Level.find(review_params[:reviewable_id])
    @athlete = AthleteProfile.find_by(user_id: review_params[:user_id])
    Rails.logger.debug @athlete
    # if @review.save
    #   respond_to do |format|
    #     format.turbo_stream
    #     format.html { redirect_to athlete_profiles, notice: 'Review added successfully.' }
    #   end
    # else
    #   render turbo_stream: turbo_stream.replace('review_form', partial: 'reviews/form', locals: { review: @review })
    # end
    #
    if @review.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            # use flash if needed
            # turbo_stream.replace("flash_messages", partial: "shared/flash_messages", locals: { flash_message: flash[:notice] }), # rubocop:disable Layout/LineLength
            turbo_stream.append("reviews_#{@level.id}", partial: 'athlete_profiles/reviews/review',
                                                        locals: { review: @review, level: @level, athlete: @athlete }),
            turbo_stream.replace("review_form_#{@level.id}", partial: 'athlete_profiles/reviews/form',
                                                             locals: { review: Review.new, level: @level, athlete: @athlete }) # rubocop:disable Layout/LineLength
          ]
        end
        format.html { redirect_to athlete_profiles, notice: 'Review created.' } # rubocop:disable Rails/I18nLocaleTexts
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('review_form', partial: 'reviews/form',
                                                                   locals: { review: @review, level: @level, athlete: @athlete }) # rubocop:disable Layout/LineLength
        end
        format.html { render :new, status: :unprocessable_content }
      end
    end
  end

  private

  def review_params
    params.require(:reviews).permit(:comment, :reviewable_type, :reviewable_id, :coach_id, :user_id)
  end
end
