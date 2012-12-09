require 'spec_helper'

describe User do
  before {@user = User.new(name: "Example User", email: "example@user.com", password: "foobar", password_confirmation: "foobar")}
  
  subject {@user}

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) } 
  it { should respond_to(:admin)} 
  it {should respond_to(:posts)}
  it {should respond_to(:ratings)}
  

  it { should be_valid }
  it { should_not be_admin}

  describe "with admin set true" do 
    before do
      @user.save!
      @user.toggle!(:admin)
    end
    it {should be_admin}
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end


  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before {@user.password=@user.password_confirmation=" "}
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before {@user.password_confirmation = nil}
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end
  
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "when email is already taken" do
    before do
      user_with_same_mail = @user.dup
      user_with_same_mail.save
    end
    
    it {should_not be_valid}
  end

  describe "when email is already taken upcase" do
    before do
      user_with_same_mail = @user.dup
      user_with_same_mail.email = @user.email.upcase
      user_with_same_mail.save
    end
    
    it {should_not be_valid}
  end

  describe "when password is short" do
    before {@user.password_confirmation = "a"*5}
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }
    
    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end
    
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before {@user.save}
    its(:remember_token) {should_not be_blank} #it { @user.remember_token.should_not be_blank }
  end

  describe "post-user associations" do
    before {@user.save}
    let(:book){FactoryGirl.create(:book)}
    let!(:first_post) do 
      FactoryGirl.create(:post, user: @user, book: book, created_at: 1.day.ago )
    end
    let!(:last_post) do 
      FactoryGirl.create(:post, user: @user, book: book, created_at: 1.hour.ago )
    end  

    it "should destroy associated posts" do
      posts = @user.posts.dup
      @user.destroy
      posts.should_not be_empty
      posts.each do |post|
        Post.find_by_id(post.id).should be_nil
       end    
     end
   end

   describe "rating-user assiciations" do
     before {@user.save}
     let(:book){FactoryGirl.create(:book)}
     let(:book1){FactoryGirl.create(:book)}
     let!(:fst_rating) do
       FactoryGirl.create(:rating, score: 5, user: @user, book: book)
     end
     let!(:lst_rating) do 
       FactoryGirl.create(:rating, score: 8, user: @user, book: book1)
     end

     it "should destroy associated ratings" do
       ratings = @user.ratings.dup
       @user.destroy
       ratings.should_not be_empty
       ratings.each do |rating|
         Rating.find_by_id(rating.id).should be_nil
       end
     end

     
   end 
end
