require 'spec_helper'

describe "public/dungeon.html.erb" do
  it "should have have content 'Stenver Jerkku'" do
    visit '/'
    expect(page).to have_content('')
  end
end
