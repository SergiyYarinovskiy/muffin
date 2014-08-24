require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

describe 'Work with the hotel process', type: :feature do
  before(:all) do
    Capybara.current_driver = :selenium
    DatabaseCleaner.clean
    @user = User.create(email: 'example@email.com', password: 'example@email.com')
  end

  before (:each) do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
    end
    click_button 'Sign in'
  end

  it 'creates hotel' do
    visit '/hotels/new'
    within('#new_hotel') do
      fill_in 'hotel_title', with: 'Hotel title'
      fill_in 'hotel_address_attributes_country', with: 'Ukraine'
    end
    click_button 'Create Hotel'
    expect(page).to have_content 'Hotel title'
  end

  it 'destroys hotel', js: true do
    visit '/hotels/new'
    within('#new_hotel') do
      fill_in 'hotel_title', with: 'Hotel title'
      fill_in 'hotel_address_attributes_country', with: 'Ukraine'
    end
    click_button 'Create Hotel'
    click_link 'Main page'
    click_link 'Destroy'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_no_content 'Hotel title'
  end

  it 'creates comment' do
    visit '/hotels/new'
    within('#new_hotel') do
      fill_in 'hotel_title', with: 'Hotel title'
      fill_in 'hotel_address_attributes_country', with: 'Ukraine'
    end
    click_button 'Create Hotel'
    within('#new_comment') do
      fill_in 'comment_body', with: 'Comment body'
    end
    click_button 'Create Comment'
    expect(page).to have_content 'Comment successfully created' and
        expect(page).to have_content 'Comment body'
  end

  after(:all) do
    Capybara.use_default_driver
  end
end
