class HomesController < ApplicationController
  before_action :user_all
  def index
    @prescriptions = Prescription.all
  end

  def doctors_index	
    @users = @users.where("role = ?","doctor")
  end

  def receptionists_index
    @users = @users.where("role = ?","receptionist")
  end

  def edit
    @user = User.find(params[:id])
    render :partial => 'edit'
  end

  def destroy  
    @user = User.where("id = ?",params[:id]).first
    # if @user.present?
       # @user.destroy
    render text: "success"
    # end
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(user_params)
    #render :partial => "users",:object => {@users => user}
    #render 'receptionists_index'
    render text: "success"
  end

  def show
    @user = User.find(params[:id])
  end



  private
    def user_all
  	 @users = User.all
    end

    def user_params
      params.require(:user).permit(:name, :sex, :phone)
    end
end
