require 'spec_helper'

describe "RatingPages" do
  subject {page}
  let(:user){FactoryGirl.create(:user)}
  let(:user1){FactoryGirl.create(:user)}
  let(:book){FactoryGirl.create(:book)}
  let!(:rating){FactoryGirl.create(:rating, user: user1, book: book)} 

  describe "rating creation for signed-in users" do
    before{sign_in user}
    before{visit book_path(book)}
    
    it "should create a rating" do
        fill_in 'rating_score', with: 6
        expect { click_button "Rate book" }.to change(Rating, :count)
    end

    it "should not create a rating - string" do
        fill_in 'rating_score', with: "aaa"
        expect { click_button "Rate book" }.not_to change(Rating, :count)
    end

    it "should not create a rating - low value" do
        fill_in 'rating_score', with: -5
        expect { click_button "Rate book" }.not_to change(Rating, :count)
    end

    it "should not create a rating - high value" do
        fill_in 'rating_score', with: 256
        expect { click_button "Rate book" }.not_to change(Rating, :count)
    end
  end

  describe "rating already created" do
    before{sign_in user1}
    before{visit book_path(book)}

    it {should have_selector('div', text: "Your rating")}
  end
  
end
