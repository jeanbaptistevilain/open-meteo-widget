require 'test_helper'

class ForecastTest < ActiveSupport::TestCase

  test "should return relevant fields" do
    forecast = build(:forecast)
    assert_equal %w(times high_clouds low_clouds medium_clouds precipitations pressure rh temp), forecast.relevant_fields
  end

  test "should match forecast with sample hour and future day" do
    sample_hour = 21
    now = Time.new(2012, 10, 17, 19, 00, 00)
    tomorrow = Time.new(2012, 10, 18, 21, 00, 00)

    today_forecast = build(:forecast)
    tomorrow_forecast = build(:forecast, times: tomorrow.to_i.to_s)

    assert_not today_forecast.is_eligible?(sample_hour, now)
    assert tomorrow_forecast.is_eligible?(sample_hour, now)
    assert_not tomorrow_forecast.is_eligible?(22, now)
  end

end