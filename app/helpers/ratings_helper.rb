module RatingsHelper

  def total_rating(book)
    total = 0    
    book.ratings.all.each do |rating|
      total += rating.score
    end
    total / book.ratings.all.count
  end

end
