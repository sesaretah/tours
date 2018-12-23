require 'test_helper'

class PassengersControllerTest < ActionController::TestCase
  setup do
    @passenger = passengers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:passengers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create passenger" do
    assert_difference('Passenger.count') do
      post :create, passenger: { birthdate: @passenger.birthdate, business_id: @passenger.business_id, name: @passenger.name, nation_id: @passenger.nation_id, passport_no: @passenger.passport_no, place_of_birth: @passenger.place_of_birth, sex: @passenger.sex, ssn: @passenger.ssn, surename: @passenger.surename, tel: @passenger.tel }
    end

    assert_redirected_to passenger_path(assigns(:passenger))
  end

  test "should show passenger" do
    get :show, id: @passenger
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @passenger
    assert_response :success
  end

  test "should update passenger" do
    patch :update, id: @passenger, passenger: { birthdate: @passenger.birthdate, business_id: @passenger.business_id, name: @passenger.name, nation_id: @passenger.nation_id, passport_no: @passenger.passport_no, place_of_birth: @passenger.place_of_birth, sex: @passenger.sex, ssn: @passenger.ssn, surename: @passenger.surename, tel: @passenger.tel }
    assert_redirected_to passenger_path(assigns(:passenger))
  end

  test "should destroy passenger" do
    assert_difference('Passenger.count', -1) do
      delete :destroy, id: @passenger
    end

    assert_redirected_to passengers_path
  end
end
