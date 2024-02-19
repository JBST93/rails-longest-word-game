class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new()
    @num_letters = 10
    @game = []
    while @num_letters != 0
      @game << ("A".."Z").to_a.sample
      @num_letters -= 1
    end
    self.score()
  end

  def score()
    @word = params[:trial]
    url = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    json_file = JSON.parse(url)


    def valid(word, game)
      if word.upcase.chars.all? { |letter| game.include?(letter) ? game.delete_at(game.index(letter)) : false }
        @score = word.length
        @message = "Congratulations!"
      else
        @score = 0
        @message = "You did not use a good combination!"
      end
      return @score
      return @message
    end

    if json_file["found"]
      valid(@word, @game)
    else
      @score = 0
      @message = "This is not an English Word"
    end

    return @score
    return @message

  end
end










#       unless @word.nil?

#         def word_ok(word_array)
#           word_array.all { |letter| @game.include?(letter) ? @game.delete_at(@game.index(letter)) : false }
#         end

#         @check = word_ok(@word.upcase.chars)

#         url = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
#         res = JSON.parse(url)

#         if word_ok(@word_array)
#           if res["found"] === false
#             @score = "Word not found"
#           else
#             @score = "Word found"
#           end
#         else
#           @score = "Word does not exist"
#         end
#     else
#     @score = "No word provided"
#     end
#   end
# end
