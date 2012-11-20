require 'spec_helper'

describe Post do
  #binding.pry
  let(:user){FactoryGirl.create(:user)}
  let(:book){FactoryGirl.create(:book)}

  before {@post=user.posts.build(content: "Lorem ipsum dolor", book_id: book.id)} 

  subject {@post}
  
  it {should respond_to(:content)}
  it {should respond_to(:user_id)}
  it {should respond_to(:book_id)}
  it {should respond_to(:user)}
  it {should respond_to(:book)}
  its(:user) {should == user}
  its(:book) {should == book}

#  describe "accesible attributes" do
#    it "should not allow access to user id" do
#      expect do
#        Post.new(user_id: user.id)
#      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
#    end
#  end

  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end

  describe "when book id not present" do
    before {@post.book_id = nil}
    it {should_not be_valid}
  end

  describe "with blank content" do
    before { @post.content = " " }
    it { should_not be_valid }
  end

  
   

end		
