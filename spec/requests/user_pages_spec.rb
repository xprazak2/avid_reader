require 'spec_helper'

include ApplicationHelper

describe "User pages" do
  include Rails.application.routes.url_helpers
  subject {page}

    describe "signup page" do
      before { visit signup_path }
        
        it {should have_selector('h1', text: 'Sign up')}
        it { should have_selector('title', text: full_title('Sign up')) }
    end
end
