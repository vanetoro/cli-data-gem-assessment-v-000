class TrendingThisWeek::CLI
    attr_accessor :name, :location, :type, :rank, :rank_change, :url, :address, :city, :phone_number, :features

  def call
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
      when 'exit'
        goodbye
      else
        puts "I didn't get that, please try again!"

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
    user_pick = instance_array[user_input]
    TrendingThisWeek::Spots.spot_more_info(user_pick)
    # binding.pry
    puts "What additional information would you like to know?
    1. Phone number
    2. Address
    3. City
    4. Features
    or all to list all the info.
    "
    user_choice = gets
    list_info(user_pick, user_choice)
    # binding.pry
  end

  def list_info(spot_instance, more_info)
    # binding.pry
    more_info = more_info.strip

      case more_info
      when '1'
        puts "#{spot_instance.phone_number}"
      when '2'
        puts "#{spot_instance.address}"
      when '3'
        puts "#{spot_instance.city}"
      when '4'
          feature(spot_instance)
      when 'all'
        puts
        "Rank #{spot_instance.rank} - #{spot_instance.name} - #{spot_instance.type}
        Address: #{spot_instance.address} - #{spot_instance.location} - #{spot_instance.city}
        Phone: #{spot_instance.phone_number}"
        feature(spot_instance)
      when 'exit'
            goodbye
      else
        gets = more_info
      end

  end

  def feature(instance)
    if instance.features.length > 0
      puts "Additional Information:"
    instance.features.each do | feature|
      puts "#{feature}"
    end
  end
  end


  def goodbye
    puts 'See you next time!'
  end
end
