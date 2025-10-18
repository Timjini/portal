# frozen_string_literal: true

class CompetitionEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_competition

  def new
    @competition_entry = @competition.competition_entries.new
  end

  def create
    @competition_entry = @competition.competition_entries.new(user: current_user)

    if @competition_entry.save
      redirect_to competitions_path, notice: 'You successfully registered!' # rubocop:disable Rails/I18nLocaleTexts
    else
      # Grab all error messages and join them into a single string
      redirect_to competitions_path, alert: @competition_entry.errors.full_messages.to_sentence
    end
  end

  private

  def set_competition
    @competition = Competition.find(params[:competition_id])
  end
end
