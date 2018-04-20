class TrendingThisWeek::List
    attr_accessor :list_name, :list_url


    def self.list_to_hash(url)
      list_array = []
        TrendingThisWeek::Scraper.scrape_list_page(url).each do |lists|

          list = self.new
          list.list_name = lists[:list_name]
          list.list_url = lists[:list_url]
          list_array << list
        end
        list_array
    end

end
