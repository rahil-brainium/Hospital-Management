class PatientsController < ApplicationController
  def show
  	@patient = Patient.find(params[:id])
  end
  def edit
    @patient = Patient.find(params[:id])
  end
  def update
    debugger
    @patient = Patient.find(params[:id])
    patient_address = params[:patient][:address][:name]
    address = Address.where("addressable_id = ?", "#{@patient.id}")
    if params[:patient][:name] == "" || params[:patient][:phone] == "" || params[:patient][:sex] == "" || params[:patient][:disease_type] == "" || params[:patient][:address][:name] == "" 
      flash[:notice] = "please fill in the details"
      redirect_to :back
    else
      @patient.update_attributes(patient_params)
      @patient.address.update_attribute(:name,patient_address)
      redirect_to "/homes/index"
      flash[:notice] = "Successfully Updated"
    end
  end

  def new
    @patient = Patient.new
    #address = Address.where("addressable_id = ?", "#{@patient.id}")
  end

  def create
    debugger
    @patient = Patient.create(patient_params)
    patient_org_id = current_user.organisation_id
    @patient.organisation_id = patient_org_id

    @patient.save
    redirect_to root_url
  end

private
  def patient_params
    params.require(:patient).permit(:name, :sex, :phone, :email,:disease_type,:avatar,:organisation_id)
  end
end
