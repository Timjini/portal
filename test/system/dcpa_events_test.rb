# frozen_string_literal: true

require 'application_system_test_case'

class DcpaEventsTest < ApplicationSystemTestCase
  setup do
    @dcpa_event = dcpa_events(:one)
  end

  test 'visiting the index' do
    visit dcpa_events_url
    assert_selector 'h1', text: 'Dcpa events'
  end

  test 'should create dcpa event' do
    visit dcpa_events_url
    click_on 'New dcpa event'

    fill_in 'Ages available', with: @dcpa_event.ages_available
    fill_in 'Coach', with: @dcpa_event.coach
    fill_in 'Dates', with: @dcpa_event.dates
    fill_in 'Dcpa discount', with: @dcpa_event.dcpa_discount
    fill_in 'Event type', with: @dcpa_event.event_type
    fill_in 'Extras', with: @dcpa_event.extras
    fill_in 'Location', with: @dcpa_event.location
    fill_in 'Price', with: @dcpa_event.price
    fill_in 'Time end', with: @dcpa_event.time_end
    fill_in 'Time start', with: @dcpa_event.time_start
    fill_in 'Title', with: @dcpa_event.title
    click_on 'Create Dcpa event'

    assert_text 'Dcpa event was successfully created'
    click_on 'Back'
  end

  test 'should update Dcpa event' do
    visit dcpa_event_url(@dcpa_event)
    click_on 'Edit this dcpa event', match: :first

    fill_in 'Ages available', with: @dcpa_event.ages_available
    fill_in 'Coach', with: @dcpa_event.coach
    fill_in 'Dates', with: @dcpa_event.dates
    fill_in 'Dcpa discount', with: @dcpa_event.dcpa_discount
    fill_in 'Event type', with: @dcpa_event.event_type
    fill_in 'Extras', with: @dcpa_event.extras
    fill_in 'Location', with: @dcpa_event.location
    fill_in 'Price', with: @dcpa_event.price
    fill_in 'Time end', with: @dcpa_event.time_end
    fill_in 'Time start', with: @dcpa_event.time_start
    fill_in 'Title', with: @dcpa_event.title
    click_on 'Update Dcpa event'

    assert_text 'Dcpa event was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Dcpa event' do
    visit dcpa_event_url(@dcpa_event)
    click_on 'Destroy this dcpa event', match: :first

    assert_text 'Dcpa event was successfully destroyed'
  end
end
