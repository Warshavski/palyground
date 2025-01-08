# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Genre, type: :model do
  subject(:genre) { described_class.new(params) }
  let(:params) { {} }

  describe 'validations' do
    context 'when all required params exist' do
      let(:params) do
        {
          name: 'Роман',
          description: 'Жанр художественной литературы'
        }
      end

      it 'is valid' do
        expect(genre).to be_valid
      end
    end

    context 'when required params are missing' do

      it 'has errors for missing fields' do
        expect(genre).not_to be_valid
        errors = genre.errors.to_hash
        expect(errors.key?(:name)).to be_truthy
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:books) }
  end
end
