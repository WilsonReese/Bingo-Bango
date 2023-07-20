class Theater < ApplicationRecord
  has_many  :reservations, dependent: :nullify
end
