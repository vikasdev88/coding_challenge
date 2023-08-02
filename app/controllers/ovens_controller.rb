class OvensController < ApplicationController
  before_action :authenticate_user!
  before_action :find_oven, except: :index

  def index
    @ovens = current_user.ovens
  end

  def show; end

  def empty
    @oven.cookies.update!(storage: current_user) if @oven.cookies
    redirect_to @oven, alert: t('.oven_emptied')
  end

  private

  def find_oven
    @oven = current_user.ovens.find_by!(id: params[:id])
  end
end
