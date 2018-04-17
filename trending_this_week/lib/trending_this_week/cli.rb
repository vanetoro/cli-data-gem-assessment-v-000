class TrendingThisWeek::CLI
  def call
    list_spots
    menu

end


def list_spots
  puts 'These are the spots trending in NYC this week

        1.Mikkeller Brewing NYC

        2.Urbanspace at 570 Lex Food Court

        3.Davelle Café'

    end

  def menu
    puts 'Enter a number matching a Trending Spot for more information, type list to see the list again or type exit'
    answer = nil
      while answer != 'exit'
        answer = gets.strip.downcase
        case answer
            when '1'
              puts ' Located in Flushing Meadows-Corona Park'
            when '2'
              puts ' Located in Midtown East'
            when '3'
              puts ' Located in Lower East Side'
            when 'list'
              list_spots
            else
              puts "Not sure what you want, please try again :)"
        end
      end
      puts 'See you later!'
  end
end
