# == Schema Information
#
# Table name: theaters
#
#  id                 :bigint           not null, primary key
#  number_of_seats    :integer
#  reservations_count :integer
#  turnover_time      :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Theater < ApplicationRecord
  has_many  :reservations, dependent: :nullify

  def reservations_for_date(date)
    self.reservations.where(start_time: date.beginning_of_day..date.end_of_day)
  end

  def reservation_occurs_during_hour?(hour)
    reservations.any? do |reservation|
      start_hour = reservation.start_time.hour
      end_hour = reservation.end_time.hour
      (start_hour..end_hour).include?(hour)
    end
  end

  def reservation_overlaps_with_hour?(hour)
    reservations.any? do |reservation|
      reservation.overlaps_with_hour?(hour)
    end
  end
end
