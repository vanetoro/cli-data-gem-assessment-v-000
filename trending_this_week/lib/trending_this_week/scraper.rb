require 'nokogiri'
require 'open-uri'


class TrendingThisWeek::Scraper
      attr_accessor :name, :location, :rank_change, :type, :rank, :spot_url, :address, :city, :phone_number, :other_info

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
                    spot_url = "https://foursquare.com#{spot.children[2].children[0].attribute('href').value}"
                    if rank_change.include? 'Positive'
                        rank_change = "+ #{rank_change_value}"
                      elsif rank_change.include? 'Negative'
                        rank_change = "- #{rank_change_value}"
                      else
                        rank_change = '0'
                      end

          spot = {:name => name, :rank => rank, :rank_change => rank_change, :type => type, :location => location, :spot_url => spot_url}
          spots_array<<spot
        end
            spots_array
  end

  def self.scraper_spot_page(spot_url)
    html = open(spot_url)
    spot_page = Nokogiri::HTML(html)

    address_array = spot_page.css('.adr').text.split(/(?<!\s|[A-Z])(?=[A-Z])|,/)
    address = address_array[0]
    city = address_array[1]
    phone_number = spot_page.css('.tel').text
    # addt'l info
        i = 0
        other_info = []
        while i < spot_page.css('.venueRowKey').length
          key = spot_page.css('.venueRowKey')
          value = spot_page.css('.venueRowValue')
          other_info << "#{key[i].text} - #{value[i].text}"
          i+=1
        end
        more_info = [address, city, phone_number, other_info]
  end

end
