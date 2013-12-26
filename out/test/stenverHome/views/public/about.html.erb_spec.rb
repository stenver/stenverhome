require 'spec_helper'

describe "public/about.html.erb" do
  it "should have have content 'Cool stuff'" do
    visit '/about'
    expect(page).to have_content('')
  end
end
