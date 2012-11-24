namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "You-know-who",
                 email: "lord@voldemort.org",
                 password: "foobar",
                 password_confirmation: "foobar")                
    User.create!(name: "Edmund Blackadder",
                 email: "edmund@blackadder.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    User.create!(name: "Jose Manuel Barroso",
                 email: "jose@barroso.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    User.create!(name: "Nigel Farage",
                 email: "nigel@farage.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    User.create!(name: "Jack Carter",
                 email: "jack@carter.org",
                 password: "foobar",
                 password_confirmation: "foobar")

    20.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@example.org"
      password  = "foobar"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    Book.create!(author: "George Orwell", title: "1984")
    Book.create!(author: "Robert Cormier", title: "Chocolate War")
    Book.create!(author: "Oscar Wilde", title: "The Happy Prince and Other Stories")
    Book.create!(author: "J. R. R. Tolkien", title: "Lord of the Rings: The Fellowship of the Ring")
    Book.create!(author: "Jeff Jeffty Jeff", title: "The Constant Carpenter")
    
  end     

  task create_posts: :environment do 
      
   users = User.all.last(7)
   book = Book.first
    30.times do       
      users.each do |user|
        content = Faker::Lorem.sentence(5)
        user.posts.create!(content: content, book_id: book.id) 
      end  
    end
  end

  task create_ratings: :environment do  
    users = User.all.last(10)    
    book = Book.first
    users.each do  |user|  
        scor = rand(0..100)
        user.ratings.create!( book_id: book.id, score: scor)
    end    
  end

end
