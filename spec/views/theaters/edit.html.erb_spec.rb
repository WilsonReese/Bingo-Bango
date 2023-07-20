require 'rails_helper'

RSpec.describe "theaters/edit", type: :view do
  let(:theater) {
    Theater.create!(
      number_of_seats: 1,
      turnover_time: 1.5,
      reservations_count: 1
    )
  }

  before(:each) do
    assign(:theater, theater)
  end

  it "renders the edit theater form" do
    render

    assert_select "form[action=?][method=?]", theater_path(theater), "post" do

      assert_select "input[name=?]", "theater[number_of_seats]"

      assert_select "input[name=?]", "theater[turnover_time]"

      assert_select "input[name=?]", "theater[reservations_count]"
    end
  end
end
