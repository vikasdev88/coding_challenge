class Api::OrdersController < Api::BaseController
  def index
    sleep 1 unless Rails.env.test? # simulate delay in loading
    sort_column = params[:sort_column].presence || 'created_at'
    sort_direction = params[:sort_direction].presence || 'desc'

    @orders = Order.sorted(sort_column, sort_direction)
  end

  def fulfill
    @order = Order.find(params[:id])
    @order.fulfilled = true
    @order.save!
  end
end
