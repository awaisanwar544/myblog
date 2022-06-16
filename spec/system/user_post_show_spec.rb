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
    Comment.create(user_id: 1, post_id: 1, text: 'This is the test comment')
  end

  after(:all) do
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
  end

  it 'I can see the post\'s title.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('Awais\' post')
  end

  it 'I can see who wrote the post.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('by Awais')
  end

  it 'I can see how many comments it has.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('Comments: 1')
  end

  it 'I can see how many likes it has.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('Likes: 0')
  end

  it 'I can see the post body.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('Test post')
  end

  it 'I can see the username of each commentor.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('Awais:')
  end

  it 'I can see the comment each commentor left.' do
    visit user_post_path(user_id: 1, id: 1)
    expect(page).to have_content('This is the test comment')
  end
end
