module AccountShortcut
  def create_account(name:, subdomain:)
    fill_in 'account_name', with: name
    fill_in 'account_subdomain', with: subdomain
    click_button 'Submit'
  end

  def current_subdomain
    host = URI.parse(page.current_url).host
    ActionDispatch::Http::URL.extract_subdomain(host, 1)
  end
end