require 'open-uri'
require 'json'

class GamesControllerController < ApplicationController
  def new
    generate_grid
  end

  def score
    run_game(params[:input], params[:grid].split(" "))
  end

  def generate_grid
    @grid = Array.new
    1.upto(9) do
      @grid << ('A'..'Z').to_a.sample
    end
    return @grid
  end

  def run_game(attempt, grid)
  # TODO: runs the game and return detailed hash of result
  split_attempt = attempt.split('').map { |letter| letter.upcase }
  grid_check =  split_attempt.all? { |e| grid.count(e) >= split_attempt.count(e) }

    if check_word(attempt) && grid_check
      @result = {
      score: score,
      message: 'well done'
      }
    elsif grid_check != true
      @result = {
      score: 0,
      message: 'not in the grid'
      }
    elsif check_word(attempt) != true
      @result = {
      score: 0,
      message: 'not an english word'
      }
    else
      @result = {
      score: 0,
      message: 'something about letters'
      }
    end
    return @result
  end

  def check_word(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    read = open(url).read
    word = JSON.parse(read)
      if word["found"]
        return true
      end
  end

end
