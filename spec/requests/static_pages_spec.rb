require 'spec_helper'


describe "Static pages" do
  include Rails.application.routes.url_helpers
  include ApplicationHelper

  describe "Home page" do

    it "should have the h1 'Avid Reader'" do
      visit root_path
      page.should have_selector('h1', :text => 'Avid Reader')
    end
    
    it "should have the title 'Home'" do
      visit root_path
      page.should have_selector('title', :text => "Avid Reader Project | Home")
    end    
  end
  
  describe "About page" do

    it "should have the content 'About'" do
      visit about_path
      page.should have_content('About')
    end
    
    it "should have the title 'About'" do
      visit about_path
      page.should have_selector('title',
                    :text => "Avid Reader Project | About")
    end
  end   
end
