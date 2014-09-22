require 'test_helper'

class TrackControllerTest < ActionController::TestCase
  test "should get index,show" do
    get :index,show
    assert_response :success
  end

end
