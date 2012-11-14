require 'spec_helper'

describe "Post Pages" do

  subject {page}

  let(:user){FactoryGirl.create(:user)}
  let(:book){FactoryGirl.create(:book)}
  before {sign_in user}

  describe "post creation" do
    before {visit new_book_post_path(book_id: book.id)}

    describe "with invalid info" do
       it "should not create a post" do
       expect {click_button "Create new post"}.not_to change(Post, :count)
      end

      describe "error messages" do
        before { click_button "Create new post" }
        it { should have_content('error') } 
      end       
    end
  
    describe "with valid info"  do
      before { fill_in 'post_content', with: "Lorem ipsum" }
      it "should create a post" do
        expect { click_button "Create new post" }.to change(Post, :count).by(1)
      end
    end
  end
end
