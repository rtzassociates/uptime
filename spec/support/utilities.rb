def login(user)
  visit login_path
  fill_in "Username",    with: user.username
  fill_in "Password", with: user.password
  click_button "Log in"
  # Sign in when not using Capybara as well.
  cookies[:token] = user.token
end