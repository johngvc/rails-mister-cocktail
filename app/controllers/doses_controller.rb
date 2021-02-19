class DosesController < ApplicationController

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(params[:cocktail_id])
  end

  def create
    @dose = Dose.new({description: get_dose_params["description"]})
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredient = Ingredient.find_by({name: get_dose_params["ingredient"]})

    @dose.cocktail = @cocktail
    @dose.ingredient = @ingredient
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
    params.require(:dose).permit(:description, :ingredient)
  end
end
