require 'rails_helper'

describe Cookie do
  subject { Cookie.new }

  describe "associations" do
    it { is_expected.to belong_to(:storage) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:storage) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe "Enum" do
    it { should define_enum_for(:status).with_values({ cooking: 0, ready: 1 }) }
  end
end
