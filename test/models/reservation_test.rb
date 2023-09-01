require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  test "Reservation created with valid attributes" do
    guest = create_guest
    reservation = create_reservation guest

    assert reservation.valid?
  end

  test "Reservation does not create if missing Guest association" do
    reservation = Reservation.new(
      reservation_code: "ABC123",
      start_date: Date.today,
      end_date: Date.tomorrow,
      nights: 1,
      guests: 2,
      adults: 2,
      children: 0,
      infants: 0,
      status: "accepted",
      currency: "AUD",
      payout_price: 100.00,
      security_price: 50.00,
      total_price: 150.00
    )

    assert_not reservation.valid?
  end

test "Reservation does not create if missing reservation_code field" do
    guest = create_guest

    reservation = Reservation.new(
      start_date: Date.today,
      end_date: Date.tomorrow,
      nights: 1,
      guests: 2,
      adults: 2,
      children: 0,
      infants: 0,
      status: "accepted",
      currency: "AUD",
      payout_price: 100.00,
      security_price: 50.00,
      total_price: 150.00,
      guest: guest
    )

    assert_not reservation.valid?
  end
end
