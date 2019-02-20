require 'rails_helper'

RSpec.describe Question, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  
  it { should have_many(:answers).dependent(:delete_all) }

  it { should validate_presence_of(:title) }

  it { should validate_presence_of(:description) }

end
