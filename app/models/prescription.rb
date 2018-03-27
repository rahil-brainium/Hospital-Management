class Prescription < ActiveRecord::Base
	belongs_to :user
	belongs_to :patient
	belongs_to :organisation
end
