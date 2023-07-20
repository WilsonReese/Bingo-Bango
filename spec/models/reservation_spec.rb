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
require 'rails_helper'

RSpec.describe Reservation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
