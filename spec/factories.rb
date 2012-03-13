FactoryGirl.define do
  
  factory :message do
  pickUpCode        "scott"
  contents          "hello, my name is scott"
  end


  factory :user do
  email                  "scottmosch@gmail.com"
  password               "westwood1"
  password_confirmation  "westwood1"
  end
end