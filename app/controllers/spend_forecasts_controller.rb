class SpendForecastsController < ApplicationController
  def index
    @spend_forecasts = SpendForecast.all
    if params[:sort].present?
      direction = params[:direction] == 'asc' ? 'asc' : 'desc'
      @spend_forecasts = @spend_forecasts.order("#{params[:sort]} #{direction}")
    end
  end

  def new
    @spend_forecast = spend_forecast
  end

  def update
    if spend_forecast.update(spend_forecast_params)
      redirect_to spend_forecast_path(spend_forecast)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @spend_forecast = SpendForecast.find(params[:id])
  end

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
    temp_params.merge!(status: :in_progress)
    temp_params
  end

  def process_csv(file)
    require 'csv'
    CSV.read(file.path, headers: true)
  end
end
