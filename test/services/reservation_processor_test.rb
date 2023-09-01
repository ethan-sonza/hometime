require 'test_helper'
require 'minitest/mock'
class ReservationProcessorTest < ActiveSupport::TestCase
  def setup
    @payload_type_1 = parse_from_reservations_fixtures("reservation_type_1.json")
    @payload_type_2 = parse_from_reservations_fixtures("reservation_type_2.json")
  end


  test 'Creates a Reservation and a Guest when payload type is valid' do
    valid_payload = @payload_type_1
    processor = ReservationProcessor.new(valid_payload)

    assert_difference 'Reservation.count' do
      assert_difference 'Guest.count' do
        reservation = processor.process
        assert_instance_of Reservation, reservation
        assert_instance_of Guest, reservation.guest
      end
    end
  end

  test 'Creates only one Guest if same email' do
    processor = ReservationProcessor.new(@payload_type_1)

    assert_difference 'Reservation.count' do
      assert_difference 'Guest.count' do
        reservation = processor.process
        assert_instance_of Reservation, reservation
        assert_instance_of Guest, reservation.guest
      end
    end

    processor = ReservationProcessor.new(@payload_type_2)
    assert_difference 'Reservation.count' do
      reservation = processor.process
    end

    assert_equal Reservation.count, 2
    assert_equal Guest.count, 1

  end

  test 'Raise a 406 when payload type is invalid' do
    invalid_payload = @payload_type_1
    invalid_payload.delete('start_date')
    processor = ReservationProcessor.new(invalid_payload)

    assert_raises ActionController::UnknownFormat do
      processor.process
    end
  end

  test 'Raise a 405 when the payload_type is accepted but a mapper does not exist' do
    processor = ReservationProcessor.new(@payload_type_2)

    processor.stub(:get_payload_type, 'your_stubbed_value') do
      assert_raises ActionController::MethodNotAllowed do
        reservation = processor.process
      end
    end
  end

  test 'Raise a 422 when the processor proceeds but does not create the db records' do
    processor = ReservationProcessor.new(@payload_type_2)
    processor.stub(:upsert_record, nil) do
      assert_raises ActiveRecord::RecordNotSaved do
        reservation = processor.process
      end
    end
  end
end