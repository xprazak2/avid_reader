require 'spec_helper'

describe "book pages" do
  subject {page}

  describe "index page" do   
    before do 
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:book, author: "Jib", title:"2004 in song")
      FactoryGirl.create(:book, author: "Jab", title:"2005 in limerics")
      visit books_path
    end

    it { should have_selector('title', text: 'All books') }
    it { should have_selector('h1',    text: 'All books') }

    it "should list each user" do
      Book.all.each do |book|
        page.should have_selector('li', text: book.title)
      end
    end
  end

  describe "book page" do
    let(:book){FactoryGirl.create(:book)}
    before {visit book_path(book)}

    it { should have_selector('h1',    text: book.title) }
    it { should have_selector('title', text: book.title) }  
  end

  describe "creating new book" do
   let(:user){FactoryGirl.create(:user)}
   before {sign_in user}
   before {visit new_book_path}

   let(:submit) {"Create new book"}
  
   describe "with invalid info" do
     it "should not create a book" do
       expect {click_button submit }.not_to change(Book, :count)
     end
   end

   describe "with valid info" do     
     before do       
       fill_in "Author", with: "Robert Cormier"
       fill_in "Title", with: "Chocolate War"
     end
     it "should create a book" do
       expect{click_button submit}.to change(Book, :count).by(1)
     end
   end   
  end


end
