require 'test_helper'

class ForecastInterpreterTest < ActiveSupport::TestCase

  test "should differentiate day and night in weather reference" do
    day_forecast = ForecastInterpreter.new(build(:forecast, :sunny, :daytime))
    night_forecast = ForecastInterpreter.new(build(:forecast, :sunny, :nighttime))

    assert_equal 'day-rain0-clouds0', day_forecast.weather
    assert_equal 'night-rain0-clouds0', night_forecast.weather
  end

  test "should differentiate rain and snow in weather reference" do
    rain_forecast = ForecastInterpreter.new(build(:forecast, :rainy, :daytime))
    snow_forecast = ForecastInterpreter.new(build(:forecast, :rainy, :daytime, :freezing))

    assert_equal 'day-rain2-clouds3', rain_forecast.weather
    assert_equal 'day-snow2-clouds3', snow_forecast.weather
  end

  test "should differentiate clouds and precipitations in weather reference" do
    clouds_forecast = ForecastInterpreter.new(build(:forecast, :cloudy, :daytime))
    rain_forecast = ForecastInterpreter.new(build(:forecast, :rainy, :daytime))

    assert_equal 'day-rain0-clouds3', clouds_forecast.weather
    assert_equal 'day-rain2-clouds3', rain_forecast.weather
  end

end