require 'rails_helper'

RSpec.describe "reservations/show", type: :view do
  before(:each) do
    assign(:reservation, Reservation.create!(
      user_id: 2,
      theater_id: 3,
      status: "Status",
      duration: 4.5,
      number_guests: 5,
      content_choice: "Content Choice"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Content Choice/)
  end
end
