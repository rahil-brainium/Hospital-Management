class OrganisationsController < ApplicationController
	def show_users
		org_id = params[:id]
		@org_users = User.where("organisation_id =?",org_id)
		render template: "organisations/show_users"
	end
end
