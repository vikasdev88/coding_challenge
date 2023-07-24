require 'rails_helper'

describe Oven do
  subject { Oven.new }

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_one(:cookie) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
  end
end
