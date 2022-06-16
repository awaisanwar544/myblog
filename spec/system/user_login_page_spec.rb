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
end
