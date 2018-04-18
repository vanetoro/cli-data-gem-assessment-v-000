class TrendingThisWeek::Spots
    attr_accessor :name, :location, :type, :rank, :rank_change, :url
  @@all = []



  def self.all
    @@all
  end

  def self.this_week(url)

  TrendingThisWeek::Scraper.scraper(url).each do | spots|
          spot =  self.new
          spot.name = spots[:name]
          spot.location = spots[:location]
          spot.type = spots[:type]
          spot.rank = spots[:rank]
          spot.rank_change = spots[:rank_change]
          spot.url = spots[:spot_url]
          @@all << spot
      end
      # binding.pry
      @@all
  end

end
