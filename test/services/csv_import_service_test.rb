# frozen_string_literal: true

require 'test_helper'
require 'csv'

class CsvImportServiceTest < ActiveSupport::TestCase
  setup do
    @csv_file_path = Rails.root.join('test/fixtures/files/test.csv')
    @service = CsvImportService.new(@csv_file_path)
  end

  test 'imports CSV data successfully' do
    assert File.exist?(@csv_file_path), "CSV file does not exist at #{@csv_file_path}"
    processed_rows = []
    puts "------------> #{@service.inspect}"
    # Use a block to collect rows
    @service.call do |row|
      puts "Processing Row: #{row.to_h}"
      processed_rows << row.to_h
    end

    # Check that the expected rows were processed
    expected_data = [
      { 'level' => '1', 'step' => '1',
        'checklist' => "\"Athlete stops what they are doing and focuses their attention on the coach when instructions are being given, Athlete repeats instructions back to the coach when prompted to by the coach, Athlete repeats instructions back to 1 pier chosen by the coach, Athlete can identify one key area's of self-development when prompted by the coach (example: I need to practice my drills at home), Athlete can explain how they will accomplish this task, Athlete can explain when he/she/they used the 4FIT approach in their training group.\"", 'degree' => 'development', 'category' => 'information_management' }, { 'level' => '1', 'step' => '1', 'checklist' => '"Athlete performs a double leg squat with both arms raised in front at eye level or behind ears - Hold position for 30 seconds - legs at 90 degree angle and chest in an upright position, Athlete performs a stationary forward facing lunge hold - Knee in front of the ankle / rear leg, knee close to the ground - hold for 15 seconds per side, Athlete performs a series of 10 push-ups with chest to the ground - trunk (core) must be straight - arms placed at shoulder width, Athlete performs an elbow support front plank for 30 seconds - must maintain good form - trunk (core) must be straight - no bending of the lower limbs (legs), Athlete performs a single leg squat - chair touch support - total of 6 reps per side - proximal hamstring / Glutes are the point of contact when touching the chair."', 'degree' => 'development', 'category' => 'physical_strength' }, { 'level' => '1', 'step' => '1', 'checklist' => "\"Prowler or sledge push and pull - Athlete must push and pull the prowler/sledge over a distance of 10m both there and back - total weight will be dependent on the athlete's ability. A set time must be achieved to pass this task (DC and coaches to agree on a set time), (Team bonding exercise) - Battle ship - Athletes will be placed into pairs or threes and given two mats - both teams must work together to get from one place to the other, Bulls eye - 5 attempts to throw a bean bag into 5 hoops - Hoops set at varied distances and placed on the floor - sagittal plane, Athlete performs a double leg jump over low height wicket/mini hurdle - spacing at 3 feet apart - use of arms to be included - athlete will pause on landing and take off from the same place of landing - no counter steps in between (3 wickets or mini hurdles), Athlete performs double leg skipping for 15+ repetitions - Minimal bending at the knee joint - no stopping in between.\"", 'degree' => 'development', 'category' => 'coordination' }, { 'level' => '1', 'step' => '1', 'checklist' => "\"Athlete performs an A-skip (remove use of both arms - placed behind athlete's back) + distance at 2 x 20 meters (good form/technique to be demonstrated - no leaning backwards), Athlete performs Scissors (remove use of both arms - placed behind athlete's back) + distance at 2 x 20 meters (good form/technique to be demonstrated - no leaning backwards), Athlete performs high knees (remove use of both arms - placed behind athlete's back) + distance at 2 x 20 meters (good form/technique to be demonstrated - no leaning backwards), Athlete performs light bulbs - single leg vertical displacement (remove use of both arms - placed behind athlete's back) + distance at 2 x 20 meters (good form/technique/co-ordination to be demonstrated - no leaning backwards), Athlete performs alternating bounds over cones + distance placed at 3 feet apart or (cm) + total of 9 cones + repeat 3 times - sufficient rest will be given.\"", 'degree' => 'development', 'category' => 'technical_ability' }, { 'level' => '1', 'step' => '1', 'checklist' => '"100m range 15.50 - 14.80 x 3 runs - sufficient recovery will be given - (hand and/or browser timing system), 60m range 9.40 - x 3 runs - sufficient recovery will be given - (hand and/or browser timing system), 150m range 22.30 x 2 runs - sufficient recovery will be given (hand and/or browser timing system), 200m range sub 31.00 x 2 runs - sufficient recovery will be given (hand and/or browser timing system), Bleep test - level 1-5."', 'degree' => 'development', 'category' => 'performance_time' }, { 'level' => '1', 'step' => '2', 'checklist' => nil, 'degree' => 'development', 'category' => 'information_management' }, { 'level' => '1', 'step' => '2', 'checklist' => nil, 'degree' => 'development', 'category' => 'physical_strength' }, { 'level' => '1', 'step' => '2', 'checklist' => nil, 'degree' => 'development', 'category' => 'coordination' }, { 'level' => '1', 'step' => '2', 'checklist' => nil, 'degree' => 'development', 'category' => 'technical_ability' }, { 'level' => '1', 'step' => '2', 'checklist' => nil, 'degree' => 'development', 'category' => 'performance_time' }
    ] # Replace with actual expected rows in your test.csv

    assert_equal expected_data, processed_rows
  end

  test 'raises error if file does not exist' do
    invalid_path = Rails.root.join('test/fixtures/files/nonexistent.csv')
    @service = CsvImportService.new(invalid_path)

    assert_raises(StandardError, 'File not found') do
      @service.call
    end
  end

  test 'handles empty CSV file gracefully' do
    empty_csv_file_path = Rails.root.join('test/fixtures/files/empty.csv')
    @service = CsvImportService.new(empty_csv_file_path)

    assert_nothing_raised do
      @service.call
    end

    # Check that no records were created
    assert_equal 0, Level.count
  end
end
