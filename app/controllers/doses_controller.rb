class DosesController < ApplicationController

  def destroy
    @dose = Dose.find(params[:id])
    @cocktail_dose = @dose.cocktail
    @dose.destroy
    redirect_to cocktail_path(@cocktail_dose)
  end

  def create
    @dose = Dose.new(get_dose_params)
    @cocktail = Cocktail.find(params[:cocktail_id])

    @dose.cocktail = @cocktail

    if @dose.save
      redirect_to cocktail_path(params[:cocktail_id])
    else
      render :new
    end
  end
  
  def new
    @dose = Dose.new
    @cocktail = Cocktail.find(params[:cocktail_id])
  end
  
  private
  
  def get_dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
