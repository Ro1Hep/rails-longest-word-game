require 'open-uri'

class GamesController < ApplicationController
  def new
    @alphabet = %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
    @letters = @alphabet.sample(10)
  end

  def score
    @answer = params[:answer]
    @board = params[:board]
    @included = included?(@answer, @board)
    @english_word = english_word?(@answer)
  end

  def included?(answer, board)
    answer.chars.all? { |letter| answer.count(letter) <= board.count(letter) }
  end

  def english_word?(word)
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
