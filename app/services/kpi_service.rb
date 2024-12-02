# frozen_string_literal: true

class KpiService
  def initialize(params = {})
    @params = params
  end

  def fetch_levels(page, per_page)
    Level.all.paginate(page: page, per_page: per_page).order(:degree)
  end

  def create_level # rubocop:disable Metrics/MethodLength
    title = @params[:title]
    degree = @params[:degree].to_i
    checklist_items = @params[:checklist]
    category = @params[:category].to_i
    step = @params[:level].to_i

    level = Level.new(title: title, degree: degree, category: category, step: step)

    if level.save
      checklist_items.each do |item|
        CheckList.create!(title: item, level_id: level.id)
      end
      { success: true, level: level }
    else
      { success: false, errors: level.errors.full_messages }
    end
  end

  def update_level # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    checklist_data = JSON.parse(@params[:checklist_data])
    checklist_data.each do |item|
      checklist_item = CheckList.find(item['id'])
      checklist_item.update(title: item['title'])
    end

    level = Level.find(@params[:id])
    level.update(
      title: @params[:title],
      degree: @params[:degree].to_i,
      category: @params[:category].to_i
    )

    if level.save
      { success: true, level: level }
    else
      { success: false, errors: level.errors.full_messages }
    end
  end

  def fetch_level_with_checklists
    level = Level.find(@params[:id])
    checklists = CheckList.where(level_id: level.id)
    { level: level, checklists: checklists }
  end

  def destroy_level
    level = Level.find(@params[:id])
    if level.destroy
      { success: true }
    else
      { success: false, errors: level.errors.full_messages }
    end
  end
end
