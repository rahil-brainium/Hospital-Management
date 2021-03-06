class RegistrationsController < Devise::RegistrationsController
  def create
    if simple_captcha_valid?
      @user = User.new(user_params)
      @user.role = "admin"
      organisation_name = params[:user][:organisation][:name]
      org = Organisation.where("name = ? ",organisation_name)
      if org.present?
        flash[:notice] = "Organisation already exists!"
        redirect_to :back
      else
        org = Organisation.create(:name => organisation_name)
        org_auth_token = org.id.to_s + org.created_at.to_s
        org_auth_token = Base64.strict_encode64(org_auth_token)
        org.auth_token = org_auth_token
        org.save
        @user.organisation_id = org.id
        @user.save
        redirect_to root_url
      end
    else
      flash[:notice] = "Captcha Not valid"
      redirect_to :back
    end
  end


  private
    def user_params
      params.require(:user).permit(:email, :password,:password_confirmation,:auth_token)
    end
end 