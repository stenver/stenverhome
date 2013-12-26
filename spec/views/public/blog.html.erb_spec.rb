require 'spec_helper'

describe "Blog tests" do
  it "should have have title 'Stenver Jerkku | Blog'" do
    visit '/'
    expect(page).to have_title('Stenver Jerkku | Blog')
  end
end
