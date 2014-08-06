And(/^the anonymous library screen is displayed$/) do
  enter_app_as_anonymous_user()
  expect_page(anonymous_library_page)
end

When(/^I sign in$/) do
  if anonymous_library_page.logged_out?
    anonymous_library_page.open_menu_and_signin
    sign_in_page.await
    username = test_data['users']['existing']['emailaddress']
    password = test_data['users']['existing']['password']
    sign_in_page.submit_sign_in_details(username, password)
  end
end

Then(/^I should be on the user library screen$/) do
  user_library_page.await
  expect(user_library_page).to be_displayed
end
