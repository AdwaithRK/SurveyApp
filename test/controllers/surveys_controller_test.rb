require 'test_helper'

class SurveysControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get surveys_create_url
    assert_response :success
  end

end
