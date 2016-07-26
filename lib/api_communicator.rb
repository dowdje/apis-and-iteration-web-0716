require 'rest-client'
require 'pry'
require 'json'
def get_character_hash(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  character_hash['results'].select{|c_hash| c_hash['name'].downcase == character}
end

def get_character_movies_from_api(char_hash)

  film_hash_array = []

  char_hash[0]['films'].each do |film_url|
    film_hash_request = RestClient.get(film_url)
    film_hash = JSON.parse(film_hash_request)
    film_hash_array << film_hash
  end
  film_hash_array
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |movie|
    puts movie['title']
  end
end

def show_character_movies(character)
  char_hash = get_character_hash(character)
  film_nogg = get_character_movies_from_api(char_hash)
  parse_character_movies(film_nogg)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
