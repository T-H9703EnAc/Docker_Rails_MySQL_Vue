require "test_helper"

class CrudControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get crud_search_url
    assert_response :success
  end
end
