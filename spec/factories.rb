FactoryGirl.define do
  
  factory :message do
  pickUpCode        "scott"
  contents          "hello, my name is scott"
  user_id           "1"
  end


  factory :user do
  email                  "scottmoscch@gmail.com"
  password               "westwood1"
  password_confirmation  "westwood1"
  id                      "1"
  end

  
end