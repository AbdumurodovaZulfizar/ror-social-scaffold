# rubocop:disable Layout/EndOfLine
require 'rails_helper'

RSpec.describe Friendship, type: :model do
  subject(:friendship) { build(:friendship) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to belong_to(:friend).class_name('User') }
  end
end
# rubocop:enable Layout/EndOfLine
