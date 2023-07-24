# == Schema Information
#
# Table name: reservations
#
#  id             :bigint           not null, primary key
#  content_choice :string
#  duration       :float
#  end_time       :datetime
#  number_guests  :integer
#  start_time     :datetime
#  status         :string           default("pending")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  theater_id     :integer
#  user_id        :integer
#
class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :theater

  validate :validate_guests_less_than_seats
  validate :no_conflicting_reservations
  validate :start_time_must_be_in_the_future

  scope :upcoming_week, -> { 
    where(start_time: Time.zone.now..Time.zone.now + 7.days) 
  }

  scope :future, -> { where('start_time >= ?', Time.current) }
  scope :past, -> { where('end_time < ?', Time.current) }
  scope :current, -> { where('start_time <= ? AND end_time >= ?', Time.current, Time.current) }
  
  enum status: {
    pending: 'pending',
    confirmed: 'confirmed',
    cancelled: 'cancelled',
    completed: 'completed'
  }

  def future_reservation?
    start_time >= Time.current
  end

  def overlaps_with_hour?(hour)
    (start_time.hour <= hour && end_time.hour > hour) ||
      (start_time.hour < hour && end_time.hour >= hour) ||
      (start_time.hour == hour && end_time.hour == hour) ||
      (start_time.hour > hour && end_time.hour < hour + 1)
  end

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

  def start_time_must_be_in_the_future
    errors.add(:start_time, "must be in the future") if start_time.present? && start_time < Time.current
  end
end
