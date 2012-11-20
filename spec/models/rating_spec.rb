require 'spec_helper'

describe Rating do
  
  let(:user){FactoryGirl.create(:user)}
  let(:book){FactoryGirl.create(:book)}
  
  before {@rating=user.ratings.build(score: 5, book_id: book.id)}
  subject {@rating}
  it {should respond_to(:score)}
  it {should respond_to(:book_id)}
  it {should respond_to(:user_id)}
  it {should be_valid}

  describe "when user_id not present" do
    before {@rating.user_id = nil}
    it {should_not be_valid}
  end

  describe "when book_id not present" do
    before {@rating.book_id = nil}
    it {should_not be_valid}
  end

  describe "when score not present" do
    before {@rating.score = nil}
    it {should_not be_valid}
  end

  describe "when score not a number" do
    before {@rating.score = "aaa"}
    it {should_not be_valid}
  end

  describe "when score is empty" do
    before {@rating.score = " "}
    it {should_not be_valid}
  end

  describe "when score not an appropriate number" do
    before {@rating.score = 256}
    it {should_not be_valid}
  end

  
end
