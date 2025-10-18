# frozen_string_literal: true

class CompetitionEntriesController < ApplicationController
  def create
    @competition_entry = CompetitionEntry.new(competition_entries_parms)

    return json @competition_entry if @competition_entry.save!

    json { render json: @competition_entry.errors, status: :unprocessable_entity }
  end

  private

  def competition_entries_parms
    params.require(:competition_entries).permit(:status, :user_id, :competition_id)
  end
end
