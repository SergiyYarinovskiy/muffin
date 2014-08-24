require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

describe 'the signin process', type: :feature do

  it 'signs me up' do
    DatabaseCleaner.clean
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
    end
    click_button 'Sign up'
    expect(page).to have_content 'Sign out'
  end

  it 'signs me in' do
    DatabaseCleaner.clean
    user = create(:user)
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
    end
    click_button 'Sign in'
    expect(page).to have_content 'Sign out'
  end
end