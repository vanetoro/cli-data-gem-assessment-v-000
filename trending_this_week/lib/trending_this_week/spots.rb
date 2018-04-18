class TrendingThisWeek::Spots
    attr_accessor :name, :location, :type, :rank, :rank_change
  @@all = []



  def self.all
    @@all
  end

  def self.this_week
  TrendingThisWeek::Scraper.scraper_nyc.each do | spots|
          spot =  self.new
          spot.name = spots[:name]
          spot.location = spots[:location]
          spot.type = spots[:type]
          spot.rank = spots[:rank]
          spot.rank_change = spots[:rank_change]

          @@all << spot
      end
      # binding.pry
      @@all
  end

end
