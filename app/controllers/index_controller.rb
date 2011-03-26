require 'thebet'

class IndexController < ApplicationController
  def index
    score = Score.new 2010
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
