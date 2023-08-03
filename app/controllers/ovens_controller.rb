class OvensController < ApplicationController
  before_action :authenticate_user!
  before_action :find_oven, except: :index

  def index
    @ovens = current_user.ovens
  end

  def show; end

  def cookies_status
    cookies_ready = @oven.cookies.ready.present?
    cookies_status = cookies_ready ? t('.cookies_ready_now') : t('.cookies_on_their_way')
    render json: { cookies_ready:, cookies_status: }
  end

  def empty
    if @oven.cookies.ready.present?
      @oven.cookies.ready.update!(storage: current_user)
      redirect_to @oven, alert: t('.oven_emptied')
    else
      flash.now[:alert] = t('.still_cooking')
      render :show
    end
  end

  private

  def find_oven
    @oven = current_user.ovens.find_by!(id: params[:id])
  end
end
