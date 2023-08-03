include Warden::Test::Helpers
Warden.test_mode!

feature 'Order listing', :devise, :js do
  let(:user) { create(:user) }
  let!(:orders) { create_list(:order, 10) }

  before do
    login_as(user, :scope => :user)
  end

  after do
    Warden.test_reset!
  end

  scenario 'user can view orders' do
    visit root_path
    click_link "Order listing"

    expect(page).to have_selector ".orders-table"
    expect(page).to have_selector ".orders-table tr", count: 11

    expect(page).to have_text orders[0].customer_name
    expect(page).to have_text orders[0].quantity
    expect(page).to have_text orders[0].item
    expect(page).to have_text 'In progress'
    expect(page).to have_button 'Fulfill order'
  end

  scenario 'user can Fulfill order' do
    visit root_path
    click_link "Order listing"

    within ".orders-table tr.order-#{orders[0].id}" do
      expect(page).to have_text 'In progress'
      expect(page).to have_button 'Fulfill order'
      click_button 'Fulfill order'

      expect(page).to have_text 'Fulfilled'
      expect(page).to_not have_button 'Fulfill order'
    end
  end

  scenario 'user can sort orders' do
    visit root_path
    click_link "Order listing"

    expect(page).to have_selector(".table.orders-table tbody tr:nth-child(1) td:nth-child(1)", text: '10')

    find('.sortable', text: 'Order #').click

    expect(page).to have_selector('.table.orders-table tbody tr:nth-child(1) td:nth-child(1)', text: '1')
  end
end
