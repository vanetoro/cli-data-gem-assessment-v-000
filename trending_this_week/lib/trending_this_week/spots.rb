class TrendingThisWeek::Spots
    attr_accessor :name, :location, :type, :position
  @@all = []



  def self.all
    @all
  end

  def self.this_week
    TrendingThisWeek::Scraper.scraper_nyc
    spot_1 =  self.new
    spot_1.name = 	"Mikkeller Brewing NYC"
    spot_1.location = 	"Flushing Meadows-Corona Park"
    spot_1.type = 'Brewery'
    spot_1.position = 1

    spot_2 =  self.new
    spot_2.name = 	"Urbanspace at 570 Lex"
    spot_2.location = 	"Midtown East"
    spot_2.type = 'Food Court'
    spot_2.position = 2

    [spot_1, spot_2]
    # binding.pry
  end

end
