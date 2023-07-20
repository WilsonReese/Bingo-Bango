require 'rails_helper'

RSpec.describe "theaters/index", type: :view do
  before(:each) do
    assign(:theaters, [
      Theater.create!(
        number_of_seats: 2,
        turnover_time: 3.5,
        reservations_count: 4
      ),
      Theater.create!(
        number_of_seats: 2,
        turnover_time: 3.5,
        reservations_count: 4
      )
    ])
  end

  it "renders a list of theaters" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
  end
end
