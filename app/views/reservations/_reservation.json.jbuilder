json.extract! reservation, :id, :user_id, :theater_id, :status, :start_time, :end_time, :duration, :number_guests, :content_choice, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
