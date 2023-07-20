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
end
