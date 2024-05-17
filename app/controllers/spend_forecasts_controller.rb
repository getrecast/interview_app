class SpendForecastsController < ApplicationController
  before_action :spend_forecast, only: [:new, :show]

  def index
    @spend_forecasts = SpendForecast.all
  end

  def new;end

  def update
    spend_forecast.update(spend_forecast_params)
    if spend_forecast.update(status: :in_progress)
      redirect_to spend_forecast_path(spend_forecast)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show;end

  private

  def spend_forecast
    @spend_forecast ||= if params[:id].present?
      current_user.spend_forecasts.find(params[:id])
    else
      current_user.spend_forecasts.find_by(status: :draft) || current_user.spend_forecasts.create
    end
  end

  def spend_forecast_params
    temp_params = params.require(:spend_forecast).permit(:name, :start_date, :end_date)
    temp_params.merge!(budget: process_csv(params[:spend_forecast][:budget_file])) if params[:spend_forecast][:budget_file]
    temp_params
  end

  def process_csv(file)
    require 'csv'
    CSV.read(file.path, headers: true)
  end
end
