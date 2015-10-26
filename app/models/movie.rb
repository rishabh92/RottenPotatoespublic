class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def self.find_in_tmdb(value)
    Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
    
    matching = Tmdb::Movie.find(value)
    if matching.nil?
      @movies = []
    else
      hash = Array.new()
      matching.each do |movie|
      hash.push({:tmdb_id => movie.id,:title => movie.title, :rating => 'R',	:release_date => movie.release_date})
      end
      @movies = hash
    end
  end
  def self.create_from_tmdb(tmid)
    movie_details = Tmdb::Movie.detail(tmid)
    title = movie_details["title"]
    release_date = movie_details["release_date"]
    description = movie_details["overview"]
    Movie.create({"title" => title, "rating" => 'R', "release_date" => release_date, "description" => description})
  end
end
