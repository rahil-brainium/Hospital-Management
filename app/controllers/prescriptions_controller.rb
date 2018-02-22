class PrescriptionsController < ApplicationController
	before_action :prescriptions_all
  def edit
    @prescription = Prescription.find(params[:id])
  end

  def update
    prescription = Prescription.where("id = ?",params[:id]).first
    prescription.update_attributes(prescription_params)
    redirect_to "/homes/index"
  end
  def destroy
    @prescription = Prescription.where("id = ?",params[:id]).first
    @prescription.destroy if @prescription.present?
    redirect_to "/homes/index"
  end

 private 
 def prescriptions_all
  	 @prescription = Prescription.all
    end
  def prescription_params
     params.require(:prescription).permit(:name, :med_type)
  end
end
