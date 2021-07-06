# rubocop:disable Layout/EndOfLine
require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:posts) }

    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:likes) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
# rubocop:enable Layout/EndOfLine