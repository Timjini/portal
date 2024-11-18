# frozen_string_literal: true

require 'test_helper'

class DcpaEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dcpa_event = dcpa_events(:one)
  end

  test 'should get index' do
    get dcpa_events_url
    assert_response :success
  end

  test 'should get new' do
    get new_dcpa_event_url
    assert_response :success
  end

  test 'should create dcpa_event' do
    assert_difference('DcpaEvent.count') do
      post dcpa_events_url,
           params: { dcpa_event: { ages_available: @dcpa_event.ages_available, coach: @dcpa_event.coach, dates: @dcpa_event.dates,
                                   dcpa_discount: @dcpa_event.dcpa_discount, event_type: @dcpa_event.event_type, extras: @dcpa_event.extras, location: @dcpa_event.location, price: @dcpa_event.price, time_end: @dcpa_event.time_end, time_start: @dcpa_event.time_start, title: @dcpa_event.title } }
    end

    assert_redirected_to dcpa_event_url(DcpaEvent.last)
  end

  test 'should show dcpa_event' do
    get dcpa_event_url(@dcpa_event)
    assert_response :success
  end

  test 'should get edit' do
    get edit_dcpa_event_url(@dcpa_event)
    assert_response :success
  end

  test 'should update dcpa_event' do
    patch dcpa_event_url(@dcpa_event),
          params: { dcpa_event: { ages_available: @dcpa_event.ages_available, coach: @dcpa_event.coach, dates: @dcpa_event.dates,
                                  dcpa_discount: @dcpa_event.dcpa_discount, event_type: @dcpa_event.event_type, extras: @dcpa_event.extras, location: @dcpa_event.location, price: @dcpa_event.price, time_end: @dcpa_event.time_end, time_start: @dcpa_event.time_start, title: @dcpa_event.title } }
    assert_redirected_to dcpa_event_url(@dcpa_event)
  end

  test 'should destroy dcpa_event' do
    assert_difference('DcpaEvent.count', -1) do
      delete dcpa_event_url(@dcpa_event)
    end

    assert_redirected_to dcpa_events_url
  end
end
