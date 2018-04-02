class PrescriptionsController < ApplicationController
	before_action :prescriptions_all
  skip_before_action :verify_authenticity_token
  def edit
    @prescription = Prescription.find(params[:id])
    render :partial => 'prescriptions/edit'
  end

  def update
    prescription = Prescription.where("id = ?",params[:id]).first
    if request.xhr?
      if params[:prescription][:med_type] == "" || params[:prescription][:name] == ""
        flash[:notice] = "please fill in the details"
        redirect_to :back
      else
        p_id = prescription.patient_id
        prescription.update_attributes(prescription_params)
        render partial: "show"
      end
    end
  end
    
  def destroy
    id = params[:id]
    @prescription = Prescription.where("id = ?",id).first
    if @prescription.present?
      @prescription.destroy
      render text: "success"
    end
  end

  def new
    @patient_id = params[:patient_id]
    @prescription = Prescription.new

  end

  def create
    prescription_types = params[:prescription_type]
    prescription_names = params[:prescription_name]
    prescription_quantity = params[:prescription_quantity]
    p_id = params[:patient_id]
    user_id = current_user.id
    prescription_types.keys.each_with_index do |key, index| 
      value = prescription_types.values[index]
      pname = prescription_names.values[index]
      pquan = prescription_quantity.values[index]
      @prescription = Prescription.create(:med_type => value , :name => pname,:quantity => pquan)
      @prescription.organisation_id = current_user.organisation_id
      @prescription.user_id = current_user.id
      @prescription.patient_id = p_id
      @prescription.save
    end
    redirect_to root_url
  end

  def show
    @patient = Patient.find(params[:id])
    @prescription = Prescription.where("patient_id =?","#{@patient.id}")
  end



 private 
 def prescriptions_all
  	 @prescription = Prescription.all
    end
  def prescription_params
     params.require(:prescription).permit(:name, :med_type,:user_id,:patient_id,:quantity)
  end
end
