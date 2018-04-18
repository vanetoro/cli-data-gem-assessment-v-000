class TrendingThisWeek::CLI
    attr_accessor :name, :location, :type, :rank, :rank_change, :url

  def call
    # list_spots(cities)
    more_info
  end

  def cities
    puts 'Welcome to trending spots where you can see the top trending spots from the tops cities in the US
    Please pick a city
    1. NYC
    2. Los Angeles
    3. Chicago
    4. San Francisco
    5. Austin'
    picked_city = STDIN.gets.strip

end

  def list_spots(picked_city)
    city_name = nil
    case picked_city
      when '1'
        city_name = 'NYC'
        url = "https://foursquare.com/foursquare/list/trending-this-week-new-york-city"
      when '2'
        city_name = 'Los Angeles'
        url = "https://foursquare.com/foursquare/list/trending-this-week-los-angeles"
      when '3'
        city_name = 'Chicago'
        url = "https://foursquare.com/foursquare/list/trending-this-week-chicago"
      when '4'
        city_name = 'San Francisco'
        url = "https://foursquare.com/foursquare/list/trending-this-week-san-francisco"
      when '5'
        city_name = 'Austin'
        url = "https://foursquare.com/foursquare/list/trending-this-week-austin"
    end
    # binding.pry
    puts "Here are the top spots in #{city_name.upcase}"
    TrendingThisWeek::Spots.this_week(url).each do |spot|
              puts "#{spot.rank}. #{spot.name} - #{spot.type} - #{spot.location}"
      end

end

  def more_info
    instance_array = list_spots(cities)
    puts 'Enter a number matching a Trending Spot for more information, type list to see the list again or type exit'
    user_input = STDIN.gets.to_i - 1
    url = instance_array[user_input].url
    TrendingThisWeek::Scraper.scraper_spot_page(url)
  end



end
