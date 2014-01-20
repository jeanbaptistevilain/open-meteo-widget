FactoryGirl.define do

  factory :forecast do
    times Time.new(2012, 10, 17, 21, 00, 00).to_i.to_s
    high_clouds "10"
    medium_clouds "20"
    low_clouds "0"
    precipitations "0"
    pressure "900"
    rh "79"
    temp "5.0"

    trait :freezing do
      temp "-5"
    end

    trait :daytime do
      times Time.new(2012, 10, 17, 12, 00, 00).to_i.to_s
    end

    trait :nighttime do
      times Time.new(2012, 10, 17, 23, 00, 00).to_i.to_s
    end

    trait :sunny do
      high_clouds "0"
      medium_clouds "0"
      low_clouds "0"
    end

    trait :cloudy do
      low_clouds "80"
    end

    trait :rainy do
      cloudy
      precipitations "10"
    end

  end

end