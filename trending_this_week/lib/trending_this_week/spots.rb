class TrendingThisWeek::Spots
    attr_accessor :name, :location, :type, :rank, :rank_change,  :url, :address, :city, :phone_number, :features


  # we should really be delcaring any class variables here, such as @@all

  # instead of making a class method called 'this_wee', why not just have this
  # be your #initialize method?  something like this:
=begin
  def initialize(spots)
    spot =  self.new
    spot.name = spots[:name]
    spot.location = spots[:location]
    spot.type = spots[:type]
    spot.rank = spots[:rank]
    spot.rank_change = spots[:rank_change]
    spot.url = spots[:spot_url]
    @@all << spot
  end
=end

# this way, we can now just pass in a hash that's a result of scraping, and
# only scrape from the Scraper class ... it will require a bit of refactoring
# in both the CLI and Scraper class as well, but the result would be code that's
# a bit more clean and adherent to the SRP (Single Responsibility Principle)

  def self.this_week(url)
    # move this class variable declaration up below your attr_accessors ^^
    @@all = []
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
      @@all
  end

  def self.all
    @@all
  end

  def self.spot_more_info(spot_instance)
      url = spot_instance.url
      more_info_array = TrendingThisWeek::Scraper.scraper_spot_page(url)
      spot_instance.address = more_info_array[0]
      spot_instance.city = more_info_array[1]
      spot_instance.phone_number = more_info_array[2]
      spot_instance.features = more_info_array[3]
  end




end
