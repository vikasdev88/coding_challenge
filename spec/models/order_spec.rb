require 'rails_helper'

RSpec.describe Order, type: :model do

  describe "validations" do
    it { is_expected.to validate_presence_of(:customer_name) }
    it { is_expected.to validate_presence_of(:item) }
    it { is_expected.to validate_presence_of(:pick_up_at) }
  end

  describe "Scope" do
    describe '.sorted' do
      it 'orders the records by the specified column in the specified direction' do
        first_order = create(:order, id: 1, customer_name: 'Alice Smith')
        second_order = create(:order, id: 2, customer_name: 'Jane Smith')

        sorted_orders = Order.sorted('customer_name', 'desc')

        expect(sorted_orders.first).to eq(second_order)
        expect(sorted_orders.second).to eq(first_order)
      end
    end
  end
end
