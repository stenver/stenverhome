require 'spec_helper'


describe PublicHelper do
  it "should have have content 'Stenver Jerkku'" do
    visit '/'
    expect(page).to have_content('Stenver Jerkku')
  end
end
