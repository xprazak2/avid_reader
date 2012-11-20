module RatingsHelper

  def rating_total(book)
    book.ratings.each {|rating| total += rating.score } / book.ratings.all.count
    
  end
end
