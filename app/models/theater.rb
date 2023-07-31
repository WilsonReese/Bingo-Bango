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

  def interval_reserved?(hour, quarter, date)
    start_time = date.in_time_zone.change(hour: hour, min: quarter * 15)
    end_time = start_time + 15.minutes
  
    reservations.where("start_time < ? AND end_time > ?", end_time, start_time).exists?
  end

  def next_reservation_after(time)
    reservations.where("start_time >= ?", time).order(:start_time).first
  end

end
