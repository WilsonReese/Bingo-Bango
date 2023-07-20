require 'rails_helper'

RSpec.describe "theaters/show", type: :view do
  before(:each) do
    assign(:theater, Theater.create!(
      number_of_seats: 2,
      turnover_time: 3.5,
      reservations_count: 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4/)
  end
end
