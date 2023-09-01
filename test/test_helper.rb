ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def parse_from_reservations_fixtures filename
    file = Rails.root.join('test', 'fixtures', 'reservations', filename)
    return JSON.parse(File.read(file))
  end

  def create_guest
    Guest.new(
      first_name: "John",
      last_name: "Doe",
      phone: "123-456-7890",
      email: "john@example.com"
    )
  end

  def create_reservation guest
    Reservation.create(
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
      total_price: 150.00,
      guest: guest
    )
  end

end
