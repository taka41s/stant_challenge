require "test_helper"

class PalestrasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @palestra = palestras(:one)
  end

  test "should get index" do
    get palestras_url
    assert_response :success
  end

  test "should get new" do
    get new_palestra_url
    assert_response :success
  end

  test "should create palestra" do
    assert_difference('Palestra.count') do
      post palestras_url, params: { palestra: { duration: @palestra.duration, event: @palestra.event, schedule: @palestra.schedule } }
    end

    assert_redirected_to palestra_url(Palestra.last)
  end

  test "should show palestra" do
    get palestra_url(@palestra)
    assert_response :success
  end

  test "should get edit" do
    get edit_palestra_url(@palestra)
    assert_response :success
  end

  test "should update palestra" do
    patch palestra_url(@palestra), params: { palestra: { duration: @palestra.duration, event: @palestra.event, schedule: @palestra.schedule } }
    assert_redirected_to palestra_url(@palestra)
  end

  test "should destroy palestra" do
    assert_difference('Palestra.count', -1) do
      delete palestra_url(@palestra)
    end

    assert_redirected_to palestras_url
  end
end
