module CalendarHelper
  def reservation_button_text(reservation, theater, time, next_time, date)
    theater_id = reservation.theater_id
    start_time = reservation.start_time
    end_time = reservation.end_time

    content_tag(:div, class: 'd-flex justify-content-center align-items-center', style: 'height: 100%;') do
      if time < Time.current # interval is after current time
        unavailable_button
      elsif !theater.interval_reserved?(time.hour, time.min / 15, date) # interval does not have a reservation already
        if !start_time && !end_time # start and end time not selected
          link_to new_reservation_path(start_time: time, theater_id: theater.id) do
            selectable_start_button(time)
          end
        elsif start_time && !end_time && theater.id == theater_id # correct theater column and the start time has been selected but not end_time
          if start_time > time # start_time is after the interval
            available_unselectable_button
          elsif start_time == time # start time is the interval
            link_to new_reservation_path(start_time: start_time, theater_id: theater_id, end_time: next_time) do
              selected_start_button(next_time)
            end
          elsif theater.next_reservation_after(start_time) # another reservation exists
            if theater.next_reservation_after(start_time).start_time < time # interval comes after the next reservation (cannot make overlapping res)
              available_unselectable_button
            else # interval comes before next reservation
              link_to new_reservation_path(start_time: start_time, theater_id: theater_id, end_time: next_time) do
                selectable_end_button(next_time)
              end
            end
          else # no reservation after the selected start_time
            link_to new_reservation_path(start_time: start_time, theater_id: theater_id, end_time: next_time) do
              selectable_end_button(next_time)
            end
          end
        elsif end_time && theater.id == theater_id # end_time selected and correct theater column
          if time >= start_time && next_time <= end_time # interval is contained in selected times
            link_to new_reservation_path(start_time: start_time, theater_id: theater_id, end_time: next_time) do
              selected_interval_button(start_time, end_time)
            end
          elsif theater.next_reservation_after(end_time) # there is a reservation after the selected end time
            if time < theater.next_reservation_after(end_time).start_time && time >= end_time # interval is before next reservation and after the selected end time
              link_to new_reservation_path(start_time: start_time, theater_id: theater_id, end_time: next_time) do
                selectable_end_button(next_time)
              end
            else # interval is not before the next reservation or the interval is before the end_time
              available_unselectable_button
            end
          else # no reservation after the the selected time
            if time < start_time # interval is before the start_time
              available_unselectable_button
            else # interval is after the start_time
              link_to new_reservation_path(start_time: start_time, theater_id: theater_id, end_time: next_time) do
                selectable_end_button(next_time)
              end
            end
          end
        else # reservations for other theater that are open but unable to be selected
          available_unselectable_button
        end
      else # interval is before current time
        unavailable_button
      end
    end
  end

  private

  # button methods
  def unavailable_button
    content_tag(:button, 'Unavailable', class: 'btn btn-secondary', style: '--bs-btn-padding-y: .1rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .5rem;', disabled: true)
  end

  def available_unselectable_button
    content_tag(:button, 'Available', class: 'btn btn-outline-secondary', style: '--bs-btn-padding-y: .1rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .5rem;', disabled: true)
  end

  def selectable_start_button(time)
    content_tag(:button, "#{time.strftime("%l:%M %p")} Start", class: 'btn btn-outline-primary', style: '--bs-btn-padding-y: .1rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .5rem;')
  end
  
  def selected_start_button(next_time)
    content_tag(:button, "#{next_time.strftime("%l:%M %p")} End", class: 'btn btn-primary', style: '--bs-btn-padding-y: .1rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .5rem;')
  end

  def selectable_end_button(next_time)
    content_tag(:button, "#{next_time.strftime("%l:%M %p")} End", class: 'btn btn-outline-primary', style: '--bs-btn-padding-y: .1rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .5rem;')
  end

  def selected_interval_button(start_time, end_time)
    content_tag(:button, "#{start_time.strftime("%l:%M %p")} - #{end_time.strftime("%l:%M %p")}", class: 'btn btn-primary', style: '--bs-btn-padding-y: .1rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .5rem;')
  end
end
