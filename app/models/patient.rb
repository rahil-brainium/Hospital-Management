class Patient < ActiveRecord::Base
	# has_one :user
	has_one :prescription
end
