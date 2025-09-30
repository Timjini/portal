# frozen_string_literal: true

class KpiService
  def initialize(params = {})
    @params = params
  end

  def fetch_levels(page, per_page)
    Level.includes([:check_lists]).all.paginate(page: page, per_page: per_page).order(:degree)
  end

  def fetch_level_by_params
    Level.where( degree: @params[:degree].to_i,category: @params[:category].to_i , step: @params[:step].to_i).first
  end

  def create_level # rubocop:disable Metrics/MethodLength
    title = @params[:title]
    degree = @params[:degree].to_i
    checklist_items = @params[:checklist] || []  # Handle nil case
    category = @params[:category].to_i
    step = @params[:step].to_i 
  
    level = Level.new(title: title, degree: degree, category: category, step: step)
  
    if level.save
      checklist_items.each do |item|
        if item.present? && item.strip.present?
          CheckList.create!(title: item.strip, level_id: level.id)
        end
      end
      { success: true, level: level }
    else
      { success: false, errors: level.errors.full_messages }
    end
  rescue => e
    # Add error handling for any exceptions
    { success: false, errors: ["An error occurred: #{e.message}"] }
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

  def bulk_delete_levels
    level_ids = @params
    destroy_levels = Level.where(id: level_ids.split(',')).destroy_all
    if destroy_levels
      { success: true }
    else
      { success: false, errors: destroy_levels.errors.full_messages }
    end
  end
end
