require "application_system_test_case"

class PalestrasTest < ApplicationSystemTestCase
  setup do
    @palestra = palestras(:one)
  end

  test "visiting the index" do
    visit palestras_url
    assert_selector "h1", text: "Palestras"
  end

  test "creating a Palestra" do
    visit palestras_url
    click_on "New Palestra"

    fill_in "Duration", with: @palestra.duration
    fill_in "Event", with: @palestra.event
    fill_in "Schedule", with: @palestra.schedule
    click_on "Create Palestra"

    assert_text "Palestra was successfully created"
    click_on "Back"
  end

  test "updating a Palestra" do
    visit palestras_url
    click_on "Edit", match: :first

    fill_in "Duration", with: @palestra.duration
    fill_in "Event", with: @palestra.event
    fill_in "Schedule", with: @palestra.schedule
    click_on "Update Palestra"

    assert_text "Palestra was successfully updated"
    click_on "Back"
  end

  test "destroying a Palestra" do
    visit palestras_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Palestra was successfully destroyed"
  end
end
