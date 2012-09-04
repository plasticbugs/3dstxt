FactoryGirl.define do
  
  factory :message do
  pickUpCode        "scott"
  contents          "hello, my name is scott"
  user_id           1
  end


  factory :user do
  email                  "scottmoscch@gmail.com"
  password               "password1"
  password_confirmation  "password1"
  id                      1
  end
  
  factory :game do
  asin                  "B0053BCO00"
  user_id               1
  id                    1
  end

  
end