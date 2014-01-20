class ForecastInterpreter

  MORNING = 6
  EVENING = 18

  # Source : http://en.wikipedia.org/wiki/Rain#Intensity
  LIGHT_RAIN = 2.5
  MODERATE_RAIN = 10
  HEAVY_RAIN = 50

  attr_accessor :forecast

  def initialize(forecast)
    @forecast = forecast
  end

  def weather
    sample_hour = Time.at(@forecast.times.to_i).hour
    daytime = sample_hour.between?(MORNING, EVENING) ? 'day' : 'night'
    "#{daytime}-#{precipitations_type}#{precipitations_grade}-#{clouds_type}#{clouds_grade}"
  end

  private

  def precipitations_type
    temperature = @forecast.temp.to_f
    temperature > 0 ? 'rain' : 'snow'
  end

  def precipitations_grade
    precipitations = @forecast.precipitations.to_f
    grade = 0
    unless precipitations == 0
      if precipitations < LIGHT_RAIN
        grade = 1
      elsif precipitations.between?(LIGHT_RAIN, MODERATE_RAIN)
        grade = 2
      elsif precipitations.between?(MODERATE_RAIN, HEAVY_RAIN)
        grade = 3
      else
        grade = 4
      end
    end
    grade
  end

  def clouds_type
    'clouds'
  end

  def clouds_grade
    low_clouds = @forecast.low_clouds.to_f
    medium_clouds = @forecast.medium_clouds.to_f
    high_clouds = @forecast.high_clouds.to_f

    grade = 0

    unless [low_clouds, medium_clouds, high_clouds].max == 0
      if [low_clouds , medium_clouds].max == 0
        grade = 1
      elsif [low_clouds, medium_clouds].max.between?(0, 40)
        grade = 2
      elsif [low_clouds, medium_clouds].max.between?(40, 80)
        grade = 3
      else
        grade = 4
      end
    end
    grade
  end

end