FactoryBot.define do
  factory :user do
    name {'random'}
    email {'random@random.com'}
    password {'gaggag'}
    password_confirmation {'gaggag'}

    factory :super_user do 
	  	name {'Sagar Shah'}
	  	email {'sagar@sagarshah.com'}
	  	password {'gaggag'}
	  	password_confirmation {'gaggag'}
	  	admin {true}
  	end	
  end
end
