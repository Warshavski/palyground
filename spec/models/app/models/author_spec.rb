# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  subject(:author) { described_class.new(params) }
  let(:params) { {} }

  describe 'validations' do
    context 'when all required params exists' do
      let(:params) do
        {
          first_name: 'Александр',
          last_name: 'Пушкин',
          biography: 'Русский поэт, драматург и прозаик',
          born_in: Date.parse('06-06-1799'),
          died_in: Date.parse('10-02-1837')
        }
      end
      it 'be valid' do
        expect(author).to be_valid
      end
    end
    context 'when all required params not valid' do
      let(:params) do
        {
          born_in: Date.parse('06-06-2000'),
          died_in: Date.parse('10-02-1837')
        }
      end
      it 'has errors for missing fields' do
        expect(author).not_to be_valid
        errors = author.errors.to_hash
        expect(errors.key?(:first_name)).to be_truthy
        expect(errors.key?(:last_name)).to be_truthy
        expect(errors.key?(:born_in)).to be_truthy
        expect(errors.key?(:biography)).to be_truthy
      end
    end
  end
end
