require 'rails_helper'

describe Oven do
  subject { Oven.new }

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:cookies) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
  end

  describe "Instance Methods" do
    describe "#valid_cookie_quantity?" do
      context 'when the cookie quantity is within the allowed range' do
        it 'returns true' do
          expect(subject.valid_cookie_quantity?(5)).to be(true)
          expect(subject.valid_cookie_quantity?(12)).to be(true)
        end
      end

      context 'when the cookie quantity exceeds the maximum allowed range' do
        it 'returns false' do
          expect(subject.valid_cookie_quantity?(25)).to be(false)
          expect(subject.valid_cookie_quantity?(100)).to be(false)
        end
      end

      context 'when the cookie quantity is not positive' do
        it 'returns false' do
          expect(subject.valid_cookie_quantity?(0)).to be(false)
          expect(subject.valid_cookie_quantity?(-5)).to be(false)
        end
      end
    end
  end
end
