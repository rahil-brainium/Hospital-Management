class HomesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :user_all, :except => [:update]
  def index
    @patients = Patient.where("organisation_id =? ","#{current_user.organisation_id}")
  end

  def doctors_index	
    role = params[:role]
    @users = User.doctors
  end

  def receptionists_index
    @users = User.receptionists
  end

  def edit
    @user = User.find_by_id(params[:id])
    if @user.nil?
      flash[:notice] = "User not found"
      redirect_to root_url
    else
      address = Address.where("addressable_id = ?", "#{@user.id}")
      restrict_access if @user.organisation_id != current_user.organisation_id
      if request.xhr?
        render :partial => 'edit'
      else
        render template: "homes/edit"
      end
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    if @user.nil?
      flash[:notice] = "User not found"
      redirect_to root_url
    else
      address = Address.where("addressable_id = ?", "#{@user.id}")
      if current_user.role != "super admin"
        restrict_access if @user.organisation_id != current_user.organisation_id
      end
    end
  end

  def destroy
    @user = User.where("id = ?",params[:id]).first
    if @user.nil?
      flash[:notice] = "User not found"
      redirect_to root_url
    else
      restrict_access if @user.organisation_id != current_user.organisation_id
      if @user.present?
        @user.destroy
        render text: "success"
      end
    end
  end

  def update
    @user = User.find(params[:id])
    restrict_access if @user.organisation_id != current_user.organisation_id
    address = Address.where("addressable_id = ?", "#{@user.id}")
    @user.update_attributes(user_params)
    if params[:user][:address].present?
      user_address = params[:user][:address][:name]
      @user.address.update_attribute(:name,user_address)
    end
    if request.xhr?
      if @user.role == "receptionist"
        @users = User.receptionists
        render :partial => 'receptionist_users'
      else
        @users = User.doctors
        render :partial => 'homes/doctor_users'
      end
    else 
      redirect_to root_url
    end
  end


  def user_invite
    email = params[:user][:email]
    role = params[:role]
    user_org = current_user.organisation_id
    user = User.where(:email => email).first
    if email.present?
      if user.present?
        flash[:notice] = "User is already invited"
        redirect_to :back
      else
        User.invite!(:email => email,:role => role,:organisation_id => user_org)
        @user = User.find_by_email(email)
        Address.create(:addressable_id => "#{@user.id}",:name => "",:addressable_type => "User")
        flash[:notice] = "User has been invited succesfully"
        redirect_to :back
      end
    else
      flash[:notice] = "Email cant be blank"
      redirect_to :back
    end
  end

  def edit_picture
    @user = User.find_by_id(params[:id])
    if @user.nil?
      flash[:notice] = "User not found"
      redirect_to root_url
    else
      restrict_access if @user.organisation_id != current_user.organisation_id
      render :partial => 'edit_picture'
    end
  end

  def crop_picture
    @user = User.find_by_id(params[:id])
    if @user.nil?
      flash[:notice] = "User not found"
      redirect_to root_url
    else
      restrict_access if @user.organisation_id != current_user.organisation_id
      if @user.avatar.present?
        render template: "homes/crop_picture"
      else
        flash[:notice] = "Please upload a profile picture first"
        redirect_to :back
      end
    end
  end

  def update_crop
    @users = User.find(params[:id]) 
    restrict_access if @user.organisation_id != current_user.organisation_id
    user_address = params[:user][:address][:name]
    address = Address.where("addressable_id = ?", "#{@user.id}")
    @users.update_attributes(user_params)
    @users.address.update_attribute(:name,user_address)
    redirect_to root_url
  end

  def organisation_list
    @org = Organisation.all 
  end


  def restrict_access
    render template: "homes/error"
  end

  def all_users_list
    @org = Organisation.all 
    render template: "homes/all_users"
  end

  def patient_list
    @patients = Patient.all
  end

  def org_patients
    @patients = Patient.where("organisation_id = ?", "#{current_user.organisation_id}")
    render template: "homes/patients_list"
  end


  private
  def user_all
    @users = User.where.not(:role => "super admin")
  end

  def user_params
    params.require(:user).permit(:name, :sex, :phone,:avatar,:crop_x,:crop_y,:crop_w,:crop_h)
  end
  
end
