require "application_system_test_case"

class PrefsTest < ApplicationSystemTestCase
  setup do
    @pref = prefs(:one)
  end

  test "visiting the index" do
    visit prefs_url
    assert_selector "h1", text: "Prefs"
  end

  test "creating a Pref" do
    visit prefs_url
    click_on "New Pref"

    fill_in "Name", with: @pref.name
    click_on "Create Pref"

    assert_text "Pref was successfully created"
    click_on "Back"
  end

  test "updating a Pref" do
    visit prefs_url
    click_on "Edit", match: :first

    fill_in "Name", with: @pref.name
    click_on "Update Pref"

    assert_text "Pref was successfully updated"
    click_on "Back"
  end

  test "destroying a Pref" do
    visit prefs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pref was successfully destroyed"
  end
end
