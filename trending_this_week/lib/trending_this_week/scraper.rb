require 'nokogiri'
require 'open-uri'

# nyc = https://foursquare.com/foursquare/list/trending-this-week-new-york-city
# la =  https://foursquare.com/foursquare/list/trending-this-week-los-angeles
# chicago = https://foursquare.com/foursquare/list/trending-this-week-chicago


class TrendingThisWeek::Scraper
  def self.scraper_nyc
    html = open('https://foursquare.com/foursquare/list/trending-this-week-new-york-city')

    trending = Nokogiri::HTML(html)

      binding.pry
      loop_this = trending.css('.hotThisWeekList tbody tr')
      # .each do | spot|
      binding.pry
      # rank = index + 1
      url =  spot.attribute('href').value
      name = spot.text
      neighborhood =
      binding.pry
    # end
    # binding.pry
  end
end
