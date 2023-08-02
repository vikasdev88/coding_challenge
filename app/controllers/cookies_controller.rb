class CookiesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_oven

  def new
    if @oven.cookies.present?
      redirect_to @oven, alert: t('.cookie_already_in_oven')
    end
  end

  def create
    if @oven.valid_cookie_quantity?(cookie_quantity)
      PrepareCookiesService.call(@oven, cookie_quantity, cookie_params[:fillings])
      redirect_to oven_path(@oven)
    else
      flash.now[:alert] = t('.valid_quantity')
      render :new
    end
  end

  private

  def cookie_quantity
    cookie_params[:quantity].to_i
  end

  def find_oven
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
  end

  def cookie_params
    params.require(:cookie).permit(:fillings, :quantity)
  end
end
