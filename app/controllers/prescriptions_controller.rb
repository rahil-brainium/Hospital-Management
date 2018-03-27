class PrescriptionsController < ApplicationController
	before_action :prescriptions_all
  def edit
    debugger
    @prescription = Prescription.find(params[:id])
  end

  def update
    prescription = Prescription.where("id = ?",params[:id]).first
    if params[:prescription][:med_type] == "" || params[:prescription][:name] == ""
      flash[:notice] = "please fill in the details"
      redirect_to :back
    else
      prescription.update_attributes(prescription_params)
      redirect_to "/homes/index"
    end
  end
    
  def destroy
    @prescription = Prescription.where("id = ?",params[:id]).first
    @prescription.destroy if @prescription.present?
    redirect_to "/homes/index"
  end

  def new
    @patient_id = params[:patient_id]
    @prescription = Prescription.new

  end

  def create
    prescription_types = params[:prescription_type]
    prescription_names = params[:prescription_name]
    p_id = params[:patient_id]
    user_id = current_user.id
    prescription_types.keys.each_with_index do |key, index| 
      value = prescription_types.values[index]
      pname = prescription_names.values[index]
      @prescription = Prescription.create(:med_type => value , :name => pname )
      @prescription.organisation_id = current_user.organisation_id
      @prescription.user_id = current_user.id
      @prescription.patient_id = p_id
      @prescription.save
    end
    redirect_to root_url
  end

  def show
    @patient = Patient.find(params[:id])
    @prescriptions = Prescription.where("patient_id =?",@patient.id)
  end



 private 
 def prescriptions_all
  	 @prescription = Prescription.all
    end
  def prescription_params
     params.require(:prescription).permit(:name, :med_type,:user_id,:patient_id)
  end
end
