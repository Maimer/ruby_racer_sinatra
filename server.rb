require 'sinatra'
require 'pg'

require_relative 'helpers'

get '/' do
  @scores = find_scores()
  erb :index
end

post '/scores' do
  @name = params["name"]
  @score = params["score"]
  @floor = params["floor"]
  @bombs = params["bombs"]
  @coins = params["coins"]
  if @score.to_i < 1000000 && @bombs.to_i <= @coins.to_i / 5 + 1 && @coins.to_i < 100
    save_score(@name, @score, @floor, @bombs, @coins)
  end
end
