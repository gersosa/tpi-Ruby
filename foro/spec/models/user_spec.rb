require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  
  it { should have_many(:questions).dependent(:destroy) }

  it { should have_many(:answers).dependent(:delete_all) }

  it { should validate_presence_of(:username) }

  it { should validate_presence_of(:screen_name) }

  it { should validate_presence_of(:email) }

  it { should validate_uniqueness_of(:username) }

  it { should validate_uniqueness_of(:email) }

  it { should validate_presence_of(:password_digest) }

end
