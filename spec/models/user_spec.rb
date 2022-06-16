require 'rails_helper'

RSpec.describe 'User model', type: :request do
  before(:all) do
    @user = User.create(name: 'Awais',
                        photo: 'url',
                        bio: 'Programmer',
                        postsCounter: 0,
                        email: 'test@test.com',
                        password: 'password')
    @invalid_user = User.new(name: '', photo: 'url', bio: 'Programmer', postsCounter: 0)
  end

  after(:all) do
    User.destroy_all
  end

  it 'Create valid user' do
    expect(@user).to be_valid
  end

  it 'Create invalid user due to empty name' do
    expect(@invalid_user).to_not be_valid
    expect(@invalid_user.errors[:name][0]).to be == 'Name can not be blank'
  end

  it 'Expect right error message due to empty name' do
    expect(@invalid_user).to_not be_valid
    expect(@invalid_user.errors[:name][0]).to be == 'Name can not be blank'
  end

  it 'Create invalid user due to missing postCounter' do
    user = User.new(name: 'Awais', photo: 'url', bio: 'Programmer')
    expect(user).to_not be_valid
  end

  it 'Create invalid user due to wrong postCounter value' do
    user = User.new(name: 'Awais', photo: 'url', bio: 'Programmer', postsCounter: -1)
    expect(user).to_not be_valid
  end
end
