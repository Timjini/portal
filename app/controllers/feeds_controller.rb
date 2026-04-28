# frozen_string_literal: true

class FeedsController < ApplicationController
  before_action :set_feed, only: %i[edit update destroy]

  def index
    @feeds = Feed.all.order(created_at: :desc)
  end

  def new
    @feed = Feed.new
  end

  def edit; end

  def create
    # Use .new instead of .create so validations don't run until we assign the creator
    @feed = Feed.new(feed_params)
    @feed.creator = current_user

    if @feed.save
      redirect_to dashboard_path, notice: 'Post created!' # rubocop:disable Rails/I18nLocaleTexts
    else
      flash.now[:alert] = 'Please fix the errors below.' # rubocop:disable Rails/I18nLocaleTexts
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @feed.update(feed_params)
      redirect_to dashboard_path, notice: 'Post updated!' # rubocop:disable Rails/I18nLocaleTexts
    else
      flash.now[:alert] = 'Update failed.' # rubocop:disable Rails/I18nLocaleTexts
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @feed.destroy
    redirect_to dashboard_path, notice: 'Post deleted!' # rubocop:disable Rails/I18nLocaleTexts
  end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(
      :title,
      :description,
      :feed_type,
      :media,
      metadata: %i[url event_date location]
    )
  end
end