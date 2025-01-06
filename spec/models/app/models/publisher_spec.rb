# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Publisher, type: :model do
  subject(:publisher) { described_class.new(params) }
  let(:params) { {} }

  describe 'validations' do
    context 'when all required params exist' do
      let(:params) do
        {
          name: 'Издательство 1',
          email: 'info@publisher.com',
          phone: '+79999999999',
          address: 'ул. Пушкина, д. Колотушкина',
          postcode: '123456'
        }
      end

      it 'is valid' do
        expect(publisher).to be_valid
      end
    end

    context 'when required params are missing' do

      it 'has errors for missing fields' do
        expect(publisher).not_to be_valid
        errors = publisher.errors.to_hash
        expect(errors.key?(:name)).to be_truthy
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:books) }
  end
end
