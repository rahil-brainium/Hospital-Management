class Organisation < ActiveRecord::Base
	has_many :users
	belongs_to :patient
	has_many :prescriptions
end
