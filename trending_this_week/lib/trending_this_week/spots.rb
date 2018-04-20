class TrendingThisWeek::Spots
    attr_accessor :name, :location, :type, :rank, :rank_change, :url, :address, :city, :phone_number, :features
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

  def self.spot_more_info(spot_instance)
      url = spot_instance.url
      more_info_array = TrendingThisWeek::Scraper.scraper_spot_page(url)
      spot_instance.address = more_info_array[0]
      spot_instance.city = more_info_array[1]
      spot_instance.phone_number = more_info_array[2]
      spot_instance.features = more_info_array[3]
      # binding.pry
      end
  def self.top_places(url)
    list_array = []
    list_url = url
    TrendingThisWeek::Scraper.scrape_top_places(list_url).each do |spots|
      spot =  self.new
      spot.name = spots[:name]
      spot.location = spots[:location]
      spot.type = spots[:type]
      spot.rank = spots[:rank]
      spot.rank_change = spots[:rank_change]
      spot.url = spots[:spot_url]
      list_array << spot
    end
    list_array
  end


end
