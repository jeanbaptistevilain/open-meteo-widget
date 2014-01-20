require 'open-uri'

class ForecastRequest

  attr_accessor :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def full_data(relevant_attributes)
    forecasts_data = {}
    open("http://api.ometfn.net/0.1/forecast/eu12/#{@latitude},#{@longitude}/full.json") { |f|
      f.each_line { |line|
        entry_key = line[1..line.index(':')-2] if line.include?(':')

        if relevant_attributes.include?(entry_key)
          attr_values = line[line.index('[')+1..line.index(']')-1].split(',')
          forecasts_data[entry_key] = attr_values
        end
      }
    }
    forecasts_data
  end

end