require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the h1 'Avid Reader'" do
      visit '/static_pages/home'
      page.should have_selector("h1", :text => 'Avid Reader')
    end
    
    it "should have the title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector("title", :text => "Ruby Avid Reader project | Home")
    end

  end
end
