require 'rails_helper'

RSpec.describe "theaters/new", type: :view do
  before(:each) do
    assign(:theater, Theater.new(
      number_of_seats: 1,
      turnover_time: 1.5,
      reservations_count: 1
    ))
  end

  it "renders new theater form" do
    render

    assert_select "form[action=?][method=?]", theaters_path, "post" do

      assert_select "input[name=?]", "theater[number_of_seats]"

      assert_select "input[name=?]", "theater[turnover_time]"

      assert_select "input[name=?]", "theater[reservations_count]"
    end
  end
end
