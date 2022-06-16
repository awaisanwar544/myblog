require 'rails_helper'

RSpec.describe 'User post index page', type: :system do
  before(:all) do
    user = User.create(id: 1,
                       name: 'Awais',
                       photo: 'https://via.placeholder.com/150',
                       bio: 'Programmer',
                       postsCounter: 0,
                       email: 'test@test.com',
                       password: 'password')
    Post.create(id: 1, user:, title: 'Awais\' post', text: 'Test post', likesCounter: 0, commentsCounter: 0)
  end

  after(:all) do
    Post.destroy_all
    User.destroy_all
  end

  it 'I can see the user\'s profile picture.' do
    visit user_posts_path(user_id: 1)
    expect(page.find('img')['src']).to have_content 'https://via.placeholder.com/150'
  end

  it 'I can see the user\'s username.' do
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('Awais')
  end

  it 'I can see the number of posts the user has written.' do
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('Number of posts: 1')
  end

  it 'I can see the post title.' do
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('Awais\' post')
  end

  it 'I can see some of the post\'s body' do
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('Test post')
  end

  it 'I can see the first comments on a post' do
    Comment.create(user_id: 1, post_id: 1, text: 'This is the test comment')
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('This is the test comment')
  end

  it 'I can see how many comments a post has.' do
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('Comments: 0')
  end

  it 'I can see how many Likes a post has.' do
    visit user_posts_path(user_id: 1)
    expect(page).to have_content('Likes: 0')
  end

  it "When I click on a post, it redirects me to that post's show page" do
    visit user_posts_path(user_id: 1)
    click_on('Test post')
    expect(page).to have_current_path(user_post_path(user_id: 1, id: 1))
  end
end
