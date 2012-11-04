require 'spec_helper'

describe "Authentication" do
  
  subject {page}

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid info" do
      let(:user){FactoryGirl.create(:user)}

      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
 
      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end

      describe "in the Books controller" do
        describe "submitting to the create action" do
          before { post books_path }
          specify { response.should redirect_to(signin_path) }
        end
        describe "viewing books index" do
          before {get books_path}
          specify { response.should redirect_to(signin_path) }
        end
      end
    end
  end

  #describe "book operations authorization" do
    
   # describe "adding new book" do
    #    let(:user) {FactoryGirl.create(:user)}
     #   let(:book) {FactoryGirl.create(:book)}

      #  describe "visiting the new book page" do
       #   before {visit new_book_path}
        #  it { should have_selector('title', text: 'Sign in') }
        #end
   # end
  #end
end
