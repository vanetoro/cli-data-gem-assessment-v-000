require 'nokogiri'
require 'open-uri'

# nyc = https://foursquare.com/foursquare/list/trending-this-week-new-york-city
# la =  https://foursquare.com/foursquare/list/trending-this-week-los-angeles
# chicago = https://foursquare.com/foursquare/list/trending-this-week-chicago


class TrendingThisWeek::Scraper
      attr_accessor :name, :location, :rank_change, :type, :rank

    def self.scraper(index_page)
      html = open(index_page)
      trending = Nokogiri::HTML(html)
spots_array = []
          trending.css('.hotThisWeekList tbody tr').each do |spot|
                    name = spot.children[2].children[0].text
                    rank =  spot.children[0].text.split('.')[0]
                    rank_change = spot.children[1].children[0].values[0]
                    rank_change_value = spot.children[1].children[0].text
                    type = spot.children[2].children[1].text
                    location = spot.children[3].text

                    if rank_change.include? 'Positive'
                        rank_change = "+ #{rank_change_value}"
                      elsif rank_change.include? 'Negative'
                        rank_change = "- #{rank_change_value}"
                      else
                        rank_change = '0'
                    end

                    spot = {:name => name, :rank => rank, :rank_change => rank_change, :type => type, :location => location}

                    spots_array<<spot

          end
            spots_array
  end

end
