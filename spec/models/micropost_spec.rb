require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost, user: user) }

  describe 'Association' do 
  	it { should belong_to(:user) }
  end

  describe 'valid attributes' do 
  	it { should validate_presence_of(:content) }
  	it { should validate_length_of(:content).is_at_most(140) }
  end
end
