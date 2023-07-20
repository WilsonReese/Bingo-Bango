class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :theater

  validate :validate_guests_less_than_seats
  validate :no_conflicting_reservations

  scope :upcoming_week, -> { 
    where(start_time: Time.zone.now..Time.zone.now + 7.days) 
  }
  
  enum status: {
    pending: 'pending',
    confirmed: 'confirmed',
    cancelled: 'cancelled',
    completed: 'completed'
  }

  private

  def validate_guests_less_than_seats
    if number_guests.present? && theater.present? && number_guests > theater.number_of_seats
      errors.add(:number_guests, "cannot be greater than the number of seats in the theater")
    end
  end

  def no_conflicting_reservations
    if Reservation.where(theater_id: theater_id, start_time: start_time..end_time).exists?
      errors.add(:base, "Conflicting reservation exists for this theater and time")
    end
  end
end
