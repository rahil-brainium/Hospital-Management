class Patient < ActiveRecord::Base
	# has_one :user
	has_many :prescriptions
	has_attached_file :avatar, styles: { medium: "100x100>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
 	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
 	has_one :organisation
 	has_one :address, as: :addressable
 	
end
