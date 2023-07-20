require 'rails_helper'

RSpec.describe "reservations/index", type: :view do
  before(:each) do
    assign(:reservations, [
      Reservation.create!(
        user_id: 2,
        theater_id: 3,
        status: "Status",
        duration: 4.5,
        number_guests: 5,
        content_choice: "Content Choice"
      ),
      Reservation.create!(
        user_id: 2,
        theater_id: 3,
        status: "Status",
        duration: 4.5,
        number_guests: 5,
        content_choice: "Content Choice"
      )
    ])
  end

  it "renders a list of reservations" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Content Choice".to_s), count: 2
  end
end
