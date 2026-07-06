require "test_helper"

class Api::V1::CarbonProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_carbon_projects_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_carbon_projects_show_url
    assert_response :success
  end
end
