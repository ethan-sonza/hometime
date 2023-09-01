class Reservation < ApplicationRecord
  belongs_to :guest
  validates :guest, presence: true
  validates :reservation_code, presence: true, uniqueness: true
  validates_associated :guest
  accepts_nested_attributes_for :guest
end
