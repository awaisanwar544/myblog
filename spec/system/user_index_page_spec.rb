require 'rails_helper'

RSpec.describe 'Index page', type: :system do
  before(:all) do
    @user = User.create(id: 1,
                        name: 'Awais',
                        photo: 'https://via.placeholder.com/150',
                        bio: 'Programmer',
                        postsCounter: 0,
                        email: 'test@test.com',
                        password: 'password')
  end

  after(:all) do
    User.destroy_all
  end

  it 'I can see the username of all other users.' do
    visit root_path
    expect(page).to have_content('Awais')
  end

  it 'I can see the profile picture for each user.' do
    visit root_path
    expect(page.find('img')['src']).to have_content 'https://via.placeholder.com/150'
  end

  it 'I can see the number of posts each user has written.' do
    visit root_path
    expect(page).to have_content('Number of posts: 0')
  end

  it "When I click on a user, I am redirected to that user's show page" do
    visit root_path
    click_on('Awais')
    expect(page).to have_current_path('/users/1')
  end
end
