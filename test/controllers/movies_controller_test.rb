require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  test "should get title" do
    get movies_title_url
    assert_response :success
  end

  test "should get year:integer" do
    get movies_year:integer_url
    assert_response :success
  end

  test "should get overview:text" do
    get movies_overview:text_url
    assert_response :success
  end

  test "should get image" do
    get movies_image_url
    assert_response :success
  end

  test "should get rating_api:float" do
    get movies_rating_api:float_url
    assert_response :success
  end

  test "should get rating_user:float" do
    get movies_rating_user:float_url
    assert_response :success
  end

  test "should get comment_user:text" do
    get movies_comment_user:text_url
    assert_response :success
  end

  test "should get date:date" do
    get movies_date:date_url
    assert_response :success
  end

  test "should get genres:string" do
    get movies_genres:string_url
    assert_response :success
  end

  test "should get adult:boolean" do
    get movies_adult:boolean_url
    assert_response :success
  end

  test "should get language" do
    get movies_language_url
    assert_response :success
  end

  test "should get release_date:date" do
    get movies_release_date:date_url
    assert_response :success
  end

  test "should get runtime:integer" do
    get movies_runtime:integer_url
    assert_response :success
  end
end
