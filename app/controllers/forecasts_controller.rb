class ForecastsController < ApplicationController

  SAMPLE_TIME = 12

  def new
  end

  def create
    @latitude = params[:lat]
    @longitude = params[:long]

    forecasts = retrieve_forecasts
    @weather = current_weather(forecasts)
    @forecasts = displayed_forecasts(forecasts)

    render :new
  end

  def widget
    @latitude = params[:lat]
    @longitude = params[:long]

    forecasts = retrieve_forecasts
    @weather = current_weather(forecasts)
    @forecasts = displayed_forecasts(forecasts)
  end

  private

  def retrieve_forecasts
    forecasts_data = ForecastRequest.new(@latitude, @longitude).full_data(Forecast.new.relevant_fields)

    forecasts = Array.new(forecasts_data.values[0].length) { Forecast.new }
    forecasts_data.each_pair { |attr, values|
      forecasts.each_with_index { |f, i| f.instance_variable_set("@#{attr}", values[i]) }
    }
    forecasts
  end

  def current_weather(forecasts)
    forecasts.select { |f|
      Time.now.hour == Time.at(f.times.to_i).hour && Time.at(f.times.to_i).day == Time.now.day
    }.first
  end

  def displayed_forecasts(forecasts)
    forecasts.select { |f|
      f.is_eligible?(SAMPLE_TIME, Time.now)
    }
  end

end
