require 'rails_helper'

RSpec.describe "reservations/edit", type: :view do
  let(:reservation) {
    Reservation.create!(
      user_id: 1,
      theater_id: 1,
      status: "MyString",
      duration: 1.5,
      number_guests: 1,
      content_choice: "MyString"
    )
  }

  before(:each) do
    assign(:reservation, reservation)
  end

  it "renders the edit reservation form" do
    render

    assert_select "form[action=?][method=?]", reservation_path(reservation), "post" do

      assert_select "input[name=?]", "reservation[user_id]"

      assert_select "input[name=?]", "reservation[theater_id]"

      assert_select "input[name=?]", "reservation[status]"

      assert_select "input[name=?]", "reservation[duration]"

      assert_select "input[name=?]", "reservation[number_guests]"

      assert_select "input[name=?]", "reservation[content_choice]"
    end
  end
end
