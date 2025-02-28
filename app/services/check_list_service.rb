# frozen_string_literal: true
class CheckListService
  def initialize(params)
    @params = params
  end

  def update_checklist
    ChecklistProgressService.new(@params).call
  end

  def show_athlete_status
    AthleteChecklistStatusService.new(@params).call
  end
end
