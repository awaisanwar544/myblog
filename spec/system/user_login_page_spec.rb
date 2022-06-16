require 'rails_helper'

RSpec.describe 'Login page', type: :system do
  it 'I can see the username and password inputs and the "Submit" button' do
    visit new_user_session_path
    expect(page).to have_field('Username')
    expect(page).to have_field('Password')
    expect(page).to have_button('Log in')
  end

  it 'When I click the submit button without filling in the username and the password, I get a detailed error' do
    visit new_user_session_path
    find_button('Log in').click
    expect(page).to have_content('Invalid Email or password')
  end

  it 'When I click the submit button after filling in the username and the password with incorrect data, I get
       a detailed error' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'Username', with: 'wrong@email.com'
      fill_in 'Password', with: 'wrongpassword'
    end
    find_button('Log in').click
    expect(page).to have_content('Invalid Email or password')
  end

  it 'When I click the submit button after filling in the username and the password with correct data, I am redirected
       to the root page' do
    visit new_user_session_path
    User.create(id: 21, name: 'Tester', bio: 'Test user', email: 'capybara@test.com', password: 'abc123',
                confirmed_at: Time.now)
    within('#new_user') do
      fill_in 'Username', with: 'capybara@test.com'
      fill_in 'Password', with: 'abc123'
    end
    find_button('Log in').click
    expect(page).to have_current_path(root_path)
  end
end
