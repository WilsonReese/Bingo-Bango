desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  if Rails.env.development?
    Reservation.delete_all
    Theater.delete_all
    User.delete_all
  end
  
  # create standard users
  user1 = User.create(
    email: 'user1@example.com', 
    password: 'password', 
    user_type: 'standard'
  )
  user2 = User.create(
    email: 'user2@example.com', 
    password: 'password', 
    user_type: 'standard'
  )

  # create admin user
  admin_user = User.create(
    email: 'admin@example.com', 
    password: 'password', 
    user_type: 'admin'
  )

  # create theaters
  theater1 = Theater.create(number_of_seats: 8, turnover_time: 5.0)
  theater2 = Theater.create(number_of_seats: 12, turnover_time: 10.0)

  # create reservations
  Reservation.create(
    user: user1, 
    theater: theater1, 
    start_time: DateTime.now.beginning_of_day + 12.hours, 
    end_time: DateTime.now.beginning_of_day + 13.hours, 
    duration: 1.0, 
    number_guests: 2, 
    content_choice: 'BYOC', 
    status: 'confirmed'
  )

  Reservation.create(
    user: user1, 
    theater: theater1, 
    start_time: DateTime.now.beginning_of_day + 15.hours, 
    end_time: DateTime.now.beginning_of_day + 17.hours, 
    duration: 2.0, 
    number_guests: 4, 
    content_choice: 'Physical', 
    status: 'confirmed'
  )
  Reservation.create(
    user: user1, 
    theater: theater2, 
    start_time: DateTime.now.beginning_of_day + 19.hours, 
    end_time: DateTime.now.beginning_of_day + 21.hours, 
    duration: 2.0, 
    number_guests: 6, 
    content_choice: 'New Release', 
    status: 'confirmed'
  )
  Reservation.create(
    user: user1, 
    theater: theater2, 
    start_time: DateTime.now.beginning_of_day + 22.hours, 
    end_time: DateTime.now.beginning_of_day + 23.hours, 
    duration: 2.0, 
    number_guests: 6, 
    content_choice: 'New Release', 
    status: 'confirmed'
  )

  Reservation.create(
    user: user2, 
    theater: theater1, 
    start_time: DateTime.now.beginning_of_day + 14.hours, 
    end_time: DateTime.now.beginning_of_day + 16.hours, 
    duration: 2.0, 
    number_guests: 3, 
    content_choice: 'BYOC', 
    status: 'confirmed'
  )
  Reservation.create(
    user: user2, 
    theater: theater2, 
    start_time: DateTime.now.beginning_of_day + 18.hours, 
    end_time: DateTime.now.beginning_of_day + 20.hours, 
    duration: 2.0, 
    number_guests: 5, 
    content_choice: 'BYOC', 
    status: 'confirmed'
  )
  Reservation.create(
    user: user2, 
    theater: theater2, 
    start_time: DateTime.now.beginning_of_day + 22.hours, 
    end_time: DateTime.now.beginning_of_day + 23.hours, 
    duration: 1.0, 
    number_guests: 2, 
    content_choice: 'BYOC', 
    status: 'confirmed')
end
