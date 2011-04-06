require 'thebet'

class IndexController < ApplicationController
  def index
    response.headers['Cache-Control'] = 'public, max-age=3600'
    score = Score.new 2011
    records = score.get_records

    @scores = {}
    @players = Player.find(:all)
    puts @players
    @players.each do |player|
      @scores[player.id] = 0
      player.picks.each do |pick|
        @scores[player.id] += records[pick.team][pick.choice]
      end
    end
    
  end

end
