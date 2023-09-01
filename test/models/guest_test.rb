require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  test "Guest created with valid attributes" do
    guest = create_guest
    assert guest.valid?
  end

  test "Guest does not create if missing email field" do
    guest = Guest.new(first_name: "John", last_name: "Doe")
    assert_not guest.valid?
  end
end
