class TrendingThisWeek::CLI
    attr_accessor :name, :location, :type, :rank, :rank_change, :url, :address, :city, :phone_number, :features, :list_name
    SPOTS_ARRAY = nil

  def call
  puts  'Welcome to trending spots where you can see the top trending spots from the tops cities in the US'
    cities
    # top_places_cities
  end

  def top_places_cities
    puts "What city would you like to check out today?
    1. NYC
    2. Los Angeles
    3. Chicago
    4. San Francisco
    5. Miami"

    html = "https://foursquare.com/top-places/"
    city = gets.strip
     case city
       when '1'
        print_list("#{html}new-york-city")
       when '2'
         print_list("#{html}los-angeles")
       when '3'
         print_list("#{html}chicago")
       when '4'
         print_list("#{html}san-francisco")
       when '5'
         print_list("#{html}miami")
     end
  end

  def cities
    puts " Please pick a city
    1. NYC
    2. Los Angeles
    3. Chicago
    4. San Francisco
    5. Austin"
    picked_city = STDIN.gets.strip
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
        cities
      end
    list_spots(url,city_name)
end

  def list_spots(url, city_name)
        puts "Here are the top spots in #{city_name}"

        spots_array = TrendingThisWeek::Spots.this_week(url).each do |spot|
            puts "#{spot.rank}. #{spot.name} - #{spot.type} - #{spot.location}"
      end
  more_info(spots_array)
end


  def more_info(spots_array)
    puts 'Enter a number matching a Trending Spot for more information, type list to see the available cities again or type exit'
    user_input = STDIN.gets
    if user_input == 'list'
        cities
      elsif user_input == 'exit'
        goodbye
      else
        user_input = user_input.to_i
        user_pick = spots_array[user_input]
        TrendingThisWeek::Spots.spot_more_info(user_pick)
        additional_info(user_pick)
    end
  end

  def more_info(array)
    puts 'Enter a number matching a Trending Spot for more information, type list to see the list again or type exit'
    user_input = STDIN.gets.to_i - 1
    user_pick = SPOTS_ARRAY[user_input]
    TrendingThisWeek::Spots.spot_more_info(user_pick)
    additional_info(user_pick)
  end

  def list_info(spot_instance, spot_info)
    spot_info = spot_info.strip
      case spot_info
        when '1'
          puts "#{spot_instance.phone_number}"
          additional_info(spot_instance)
        when '2'
          puts "#{spot_instance.address}"
          additional_info(spot_instance)
        when '3'
          puts "#{spot_instance.city}"
          additional_info(spot_instance)
        when '4'
            feature(spot_instance)
            additional_info(spot_instance)
        when 'all'
          puts "Rank #{spot_instance.rank} - #{spot_instance.name} - #{spot_instance.type}
          Address: #{spot_instance.address} - #{spot_instance.location} - #{spot_instance.city}
          Phone: #{spot_instance.phone_number}".strip
          feature(spot_instance)
        when 'exit'
            goodbye
        when 'city'
        cities

      when 'spots'
        more_info(SPOTS_ARRAY)
        else
          spot_info = gets.strip
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

  def additional_info(instance)
    puts "What additional information would you like to know about #{instance.name}?
    1. Phone number
    2. Address
    3. City
    4. Features

    Type 'all' to list all the info or 'city' to see a list of the available cites.
    Type 'exit' at any time to leave"
    user_choice = gets.strip
    list_info(instance,user_choice)
  end

  def print_list(url)
     place_array = TrendingThisWeek::List.list_to_hash(url)
      place_array.each do |each_list|
        puts "#{each_list.list_name}"
      end
      place = gets.to_i - 1
      TrendingThisWeek::Spots.top_places(place_array[place].list_url).each do |listed_place|
            puts "#{listed_place.name}"
      end
  end

end
