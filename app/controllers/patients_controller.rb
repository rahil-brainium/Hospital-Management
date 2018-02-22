class PatientsController < ApplicationController
  def show
  	@patient = Patient.find(params[:id])
  end
  def edit
    @patient = Patient.find(params[:id])
  end
  def update
    patient = Patient.find(params[:id])
    patient.update_attributes(patient_params)
    redirect_to "/homes/index"
  end
private
  def patient_params
      params.require(:patient).permit(:name, :sex, :phone, :email,:disease_type)
  end
end
