module CaseShortcut
  def create_case(name:)
    fill_in 'owned_case_name', with: name
    click_button 'Submit'
  end
end