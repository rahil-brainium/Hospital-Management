namespace :update_auth_token_organisation do
  desc "TODO"
  task update_auth_token: :environment do
    Organisation.all.each do |o|
      if o.auth_token.nil?
        org_auth_token = o.id.to_s + o.created_at.to_s
        org_auth_token = Base64.strict_encode64(org_auth_token)
        o.update(:auth_token => org_auth_token)
      end
    end
  end

end
