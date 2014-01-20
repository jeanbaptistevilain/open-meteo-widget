require 'active_model'

class Forecast

  include ActiveModel::Model
  include ActiveModel::Serializers::JSON

  attr_accessor :times, :high_clouds, :low_clouds, :medium_clouds, :precipitations, :pressure, :rh, :temp

  def initialize
    @times, @high_clouds, @low_clouds, @medium_clouds, @precipitations, @pressure, @rh, @temp = ''
  end

  def relevant_fields
    instance_variables.map {|iv| iv[1..iv.length]}
  end

  def is_eligible?(sample_hour, reference_time)
    forecast_time = Time.at(@times.to_i)
    forecast_time.hour == sample_hour && (forecast_time.yday > reference_time.yday || forecast_time.year > reference_time.year)
  end

  # methods below are implemented manually as they are only available in AR modules which will not be included here

  def attributes=(hash)
    hash.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def attributes
    instance_values
  end

end
