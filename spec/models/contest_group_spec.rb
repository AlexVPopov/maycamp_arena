require 'rails_helper'

RSpec.describe ContestGroup, type: :model do
  it 'has a valid factory' do
    expect(create :contest_group).to be_valid
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  context 'associations' do
    it { should have_many(:contests) }
  end
end
