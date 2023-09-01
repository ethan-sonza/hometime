require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    guest = create_guest
    @reservation = create_reservation guest
  end

  test "should get index" do
    get reservations_url, as: :json
    assert_response :success
  end

  test "should show reservation" do
    get reservation_url(@reservation), as: :json
    assert_response :success
  end

  test "should create reservation" do
    reservation_params = parse_from_reservations_fixtures("reservation_type_1.json")
    assert_difference("Reservation.count") do
      post reservations_url, params: reservation_params, as: :json
    end
    assert_response :created
  end

  test "failure" do
    reservation_params = parse_from_reservations_fixtures("reservation_type_1.json")
    reservation_params['code'] = reservation_params['reservation_code']
    reservation_params.delete('reservation_code')
    post reservations_url, params: reservation_params, as: :json, headers: { 'Accept' => 'application/json' }
  end

end
