FactoryBot.define do
  factory :user do
    name {'random'}
    email {'random@random.com'}
    password {'gaggag'}
    password_confirmation {'gaggag'}
    activated {true}

    factory :super_user do 
	  	name {'Sagar Shah'}
	  	email {'sagar@sagarshah.com'}
	  	password {'gaggag'}
	  	password_confirmation {'gaggag'}
	  	admin {true}
      activated {true}
  	end	

  	factory :other_super_user do 
  		name {'Super'}
  		email {'super@super.com'}
  		password {'gaggag'}
  		password_confirmation {'gaggag'}
  		admin {true}
      activated {true}
  	end

    factory :non_active_user do 
      name {'non active'}
      email {'non@non.non'}
      password {'gaggag'}
      password_confirmation {'gaggag'}
      activated {false}
    end
  end
end
