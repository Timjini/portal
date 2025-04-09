# frozen_string_literal: true

class KpiController < ApplicationController
  skip_forgery_protection only: %i[create destroy update]
  before_action :authenticate_user!

  def index
    service = KpiService.new(params)
    @levels = service.fetch_levels(params[:page], 5)
  end

  def edit
    service = KpiService.new(params)
    data = service.fetch_level_with_checklists
    @level = data[:level]
    @check_list = data[:checklists]
  end

  def create # rubocop:disable Metrics/MethodLength
    service = KpiService.new(params)
    result = service.create_level

    if result[:success]
      respond_to do |format|
        format.json { render json: { status: 'success', message: 'Level created!' } }
      end
    else
      respond_to do |format|
        format.json { render json: { status: 'error', message: result[:errors].join(', ') } }
      end
    end
  end

  def update # rubocop:disable Metrics/MethodLength
    service = KpiService.new(params)
    result = service.update_level

    if result[:success]
      respond_to do |format|
        format.json do
          render json: { status: 'success', message: 'Level updated!', redirect_url: '/kpis' }
        end
      end
    else
      render json: { status: 'error', message: result[:errors].join(', ') }
    end
  end

  def destroy
    service = KpiService.new(params)
    result = service.destroy_level

    if result[:success]
      render json: { success: true }
    else
      render json: { success: false, message: result[:errors].join(', ') }
    end
  end

  def bulk_delete # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    level_ids = params[:level_ids]

    sleep 6

    if level_ids.empty?
      # respond_to do |format|
      #   format.turbo_stream do
      #     render turbo_stream: turbo_stream.replace("bulk-delete", partial: "kpis/delete_error", locals: { errors: ["Please select at least one level to delete."] }) # rubocop:disable Layout/LineLength
      #     format.html { redirect_to kpis_path, alert: "Please select at least one level to delete." }
      #   end
      # end
    end
    service = KpiService.new(level_ids)
    result = service.bulk_delete_levels
    if result[:success]
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace('bulk-delete', partial: 'kpis/delete_success') }
        format.html { redirect_to kpis_path, notice: 'Levels deleted successfully.' } # rubocop:disable Rails/I18nLocaleTexts
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('bulk-delete', partial: 'kpis/delete_error',
                                                                   locals: { errors: result[:errors] })
        end
        format.html { redirect_to kpis_path, alert: "Failed to delete: #{result[:errors].join(', ')}" }
      end
    end
  end
end
