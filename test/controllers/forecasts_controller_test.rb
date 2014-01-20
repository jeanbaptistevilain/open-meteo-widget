require 'test_helper'

class ForecastsControllerTest < ActionController::TestCase

  test "should do something" do
    get :index
    assert_response :success
    assert_not_nil assigns(:forecasts)
  end

end
