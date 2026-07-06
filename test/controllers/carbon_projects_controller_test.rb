require "test_helper"

class CarbonProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get carbon_projects_index_url
    assert_response :success
  end
end
