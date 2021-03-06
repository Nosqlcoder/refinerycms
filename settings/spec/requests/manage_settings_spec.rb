require "spec_helper"

describe "manage settings" do
  login_refinery_user

  context "when no settings" do
    before(:each) { Refinery::Setting.destroy_all }

    it "invites to create one" do
      visit refinery_admin_settings_path
      page.should have_content("There are no settings yet. Click 'Add new setting' to add your first setting.")
    end
  end

  it "shows add new setting link" do
    visit refinery_admin_settings_path
    page.should have_content("Add new setting")
    page.should have_selector("a[href*='/refinery/settings/new']")
  end

  context "new/create" do
    it "adds setting", :js => true do
      visit refinery_admin_settings_path
      click_link "Add new setting"

      fill_in "Name", :with => "test setting"
      fill_in "Value", :with => "true"
      click_button "Save"

      page.should have_content("'Test Setting' was successfully added.")
      page.should have_content("Test Setting - true")
    end
  end
end
