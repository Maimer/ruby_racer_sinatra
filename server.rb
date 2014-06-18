require 'sinatra'
require 'pg'

require_relative 'helpers'

get '/' do
  @scores = find_scores().to_a
  erb :index
end

post '/scores' do
  @scores = find_scores().to_a
  if @scores.size >= 100
    if @params["score"] > @scores.last["score"]
      if params["name"].length > 16
        @name = params["name"][0...16]
      else
        @name = params["name"]
      end
      @score = params["score"]
      @floor = params["floor"]
      @bombs = params["bombs"]
      @coins = params["coins"]
      @move = params["move"]
      if @score.to_i < 1000000 && @bombs.to_i <= @coins.to_i / 5 + 1 && @coins.to_i < 100 && @move == '13'
        save_score(@name, @score, @floor, @bombs, @coins)
        delete_score(@scores.last["id"])
      end
    end
  else
    if params["name"].length > 16
      @name = params["name"][0...16]
    else
      @name = params["name"]
    end
    @score = params["score"]
    @floor = params["floor"]
    @bombs = params["bombs"]
    @coins = params["coins"]
    @move = params["move"]
    if @score.to_i < 1000000 && @bombs.to_i <= @coins.to_i / 5 + 1 && @coins.to_i < 100 && @move == '13'
      save_score(@name, @score, @floor, @bombs, @coins)
    end
  end
end
