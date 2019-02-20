require 'rails_helper'

RSpec.describe Answer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it { should belongs_to(:question) }

  it { should belongs_to(:user) }

  it { should validate_presence_of(:content) }
  
end
