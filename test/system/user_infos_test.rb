require "application_system_test_case"

class UserInfosTest < ApplicationSystemTestCase
  setup do
    @user_info = user_infos(:one)
  end

  test "visiting the index" do
    visit user_infos_url
    assert_selector "h1", text: "User Infos"
  end

  test "creating a User info" do
    visit user_infos_url
    click_on "New User Info"

    fill_in "Address", with: @user_info.address
    fill_in "Mobile", with: @user_info.mobile
    fill_in "Name", with: @user_info.name
    fill_in "Postal code", with: @user_info.postal_code
    fill_in "Pref", with: @user_info.pref_id
    fill_in "User", with: @user_info.user_id
    click_on "Create User info"

    assert_text "User info was successfully created"
    click_on "Back"
  end

  test "updating a User info" do
    visit user_infos_url
    click_on "Edit", match: :first

    fill_in "Address", with: @user_info.address
    fill_in "Mobile", with: @user_info.mobile
    fill_in "Name", with: @user_info.name
    fill_in "Postal code", with: @user_info.postal_code
    fill_in "Pref", with: @user_info.pref_id
    fill_in "User", with: @user_info.user_id
    click_on "Update User info"

    assert_text "User info was successfully updated"
    click_on "Back"
  end

  test "destroying a User info" do
    visit user_infos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User info was successfully destroyed"
  end
end
