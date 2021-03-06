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
      let(:book) { FactoryGirl.create(:book)}
      
       after(:all) { User.delete_all }
       after(:all) { Book.delete_all }

      describe "in posts controller" do   
         
        describe "submitting to create action" do
          before {post book_posts_path(book_id: book.id) }
          specify { response.should redirect_to(signin_path) }
        end

        describe "submitting to new action" do
          before {get new_book_post_path(book_id: book.id)}
          specify { response.should redirect_to(signin_path) }
        end

        describe "submitting to destroy action" do
          before { delete book_post_path(book, FactoryGirl.create(:post)) }
          specify { response.should redirect_to(signin_path) }
        end        
      end

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

    describe "for signed in users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:admin) { FactoryGirl.create(:admin) }
      let(:book) { FactoryGirl.create(:book)}
      let(:post) { FactoryGirl.create(:post, book: book, user: user)}
      
       after(:all) { User.delete_all }
       after(:all) { Book.delete_all }
       after(:all) { Post.delete_all }
       
       describe "submiting to delete post as post owner" do
         before {sign_in user}
         before {delete book_post_path(book, post)}
         specify {response.should redirect_to(book_path(book))}         
       end

       describe "submiting to delete post as admin" do
         before {sign_in admin}
         before {delete book_post_path(book, post)}
         specify {response.should redirect_to(book_path(book))}         
       end              
    end  

  end

  #describe "book operations authorization" do
    
    #describe "adding new book" do
       # let(:user) {FactoryGirl.create(:user)}
      #  let(:book) {FactoryGirl.create(:book)}

      #  describe "visiting the new book page" do
       #   before {visit new_book_path}
      #    it { should have_selector('title', text: 'New book') }
    #    end
   # end
  #end
end
