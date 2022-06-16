require 'rails_helper'

RSpec.describe 'User show page', type: :system do
  before(:all) do
    user = User.create(id: 1,
                       name: 'Awais',
                       photo: 'https://via.placeholder.com/150',
                       bio: 'Programmer',
                       postsCounter: 0,
                       email: 'test@test.com',
                       password: 'password')
    Post.create(id: 1,
                title: 'Test post',
                text: 'This is a test post',
                commentsCounter: 0,
                likesCounter: 0,
                user_id: user.id)
  end

  after(:all) do
    Post.destroy_all
    User.destroy_all
  end
  it 'I can see the user\'s profile picture.' do
    visit user_path(id: 1)
    expect(page.find('img')['src']).to have_content 'https://via.placeholder.com/150'
  end

  it 'I can see the user\'s username.' do
    visit user_path(id: 1)
    expect(page).to have_content('Awais')
  end

  it 'I can see the number of posts the user has written.' do
    visit user_path(id: 1)
    expect(page).to have_content('Number of posts: 1')
  end

  it 'I can see the user\'s bio.' do
    visit user_path(id: 1)
    expect(page).to have_content('Programmer')
  end

  it 'I can see the user\'s first 3 posts.' do
    visit user_path(id: 1)
    expect(page).to have_content('Test post')
  end

  it "I can see a button that lets me view all of a user's posts." do
    visit user_path(id: 1)
    expect(page).to have_link('See all posts')
  end

  it "When I click a user's post, it redirects me to that post's show page." do
    visit user_posts_path(user_id: 1)
    click_on('This is a test post')
    expect(page).to have_current_path(user_post_path(user_id: 1, id: 1))
  end

  it "When I click to see all posts, it redirects me to the user's post's index page." do
    visit user_path(id: 1)
    click_on('See all posts')
    expect(page).to have_current_path(user_posts_path(user_id: 1))
  end
end
