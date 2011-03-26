require 'net/http'
require 'uri'


class Score
  def initialize(year)
   @year = year 
  end

  def get_records
    unless @records
      html = self.make_http_request
      @records = self.parse_html html
    end
    @records
  end


  def make_http_request
    url = URI.parse("http://espn.go.com/mlb/standings/_/year/#{@year}/seasontype/2")
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    res.body
  end

  def parse_html(html)
    teams = Hash.new
    html.scan(/<a href="http:\/\/espn.go.com\/mlb\/team\/_\/name\/(.*?)\/(.*?)">(.*?)<\/a><\/td><td>(.*?)<\/td><td>(.*?)<\/td>/) do |match|
      teams[match[0]] = {"code"=>match[0], "name"=>match[2], "win"=>match[3].to_i, "lose"=>match[4].to_i}
    end
    teams
  end
end

