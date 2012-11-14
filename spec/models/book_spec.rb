require 'spec_helper'

describe Book do
  before{@book=Book.new(title: "1984", author: "George Orwell" )}
   
  subject {@book}

  it {should respond_to(:title)}
  it {should respond_to(:author)}
  it {should respond_to(:posts)}

  it {should be_valid}

  describe "when title not present" do
   before {@book.title=""}
   it {should_not be_valid}   
  end

  describe "when title nill" do
   before {@book.title=nil}
   it {should_not be_valid}   
  end

  describe "when author not present" do
   before {@book.author=""}
   it {should_not be_valid}   
  end

  describe "when author nill" do
   before {@book.author=nil}
   it {should_not be_valid}   
  end

  describe "when book already present" do
    before do
      same_book=@book.dup
      same_book.save
    end
     it {should_not be_valid}
  end

  describe "when book with different author present" do
    before do
      with_same_title=@book.dup
      with_same_title.author="Rudyard Kipling"
      with_same_title.save
    end
     it {should be_valid}
  end

  describe "when book with different title present" do
    before do
      with_same_author=@book.dup
      with_same_author.title="Animal Farm"
      with_same_author.save
    end
     it {should be_valid}
  end

  describe "post-book associations" do
    before {@book.save}
    let(:user){FactoryGirl.create(:user)}
    let!(:first_post) do 
      FactoryGirl.create(:post, user: user, book: @book, created_at: 1.day.ago )
    end
    let!(:last_post) do 
      FactoryGirl.create(:post, user: user, book: @book, created_at: 1.hour.ago )
    end  

    it "should destroy associated posts" do
      posts = @book.posts.dup
      @book.destroy
      posts.should_not be_empty
      posts.each do |post|
        Post.find_by_id(post.id).should be_nil
      end  
    end
  end


end
