# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

questionnaire = Questionnaire.create(title: "Athlete registration form")

questions_data = [
  {
    content: "Has your child ever suffered with Osgood Schlatter Disease?",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: ["Yes", "No"],
    position: 1
  },
  {
    content: "Has your doctor/GP ever said that your child has a bone or joint problem, such as arthritis, that could be aggravated or made worse with exercise?",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: ["Yes", "No"],
    position: 2
  },
  {
    content: "Does your child suffer with high blood pressure?",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: ["Yes", "No"],
    position: 3
  },
  {
    content: "Does your child suffer from low blood pressure?",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: ["Yes", "No"],
    position: 4
  },
  {
    content: "Has your child ever experienced pain in their chest when performing physical activity?",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: ["Yes", "No"],
    position: 5
  },
  {
    content: "Has your doctor/GP ever said that your child has a heart condition and that he or she should only do physical activity recommended by a doctor?",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: ["Yes", "No"],
    position: 6
  },
  {
    content: "Is your doctor/GP currently prescribing any form of drugs or medication for your child?",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: ["Yes", "No"],
    position: 7
  },
  {
    content: "Is there any history of coronary heart disease in your family?",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: ["Yes", "No"],
    position: 8
  },
  {
    content: "Does your child often feel faint, have spells of dizziness or loss of consciousness at any point during exercise or on a day-to-day basis?",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: ["Yes", "No"],
    position: 9
  },
  {
    content: "Does your child suffer from any allergies or express sensitivity to anything?",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: ["Yes", "No"],
    position: 10
  },
   {
    content: "If you have answered yes to any of the above questions please outline below.",
    question_type: 'text',
    questionnaire_id: questionnaire.id,
    options: nil,
    position: 11
  },

    {
    content: "How many litres of water does your child consume per day?",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: ["Half a litre", "1 litre", "2 litres", "No water at all"],
    position: 12
  },
  {
    content: "How many times a week does your child participate in exercise?",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: ["0", "1-2", "3-5", "6+"],
    position: 13
  },
  {
    content: "If there are any medical incidents that have presented themselves in the past but haven't been highlighted within this PAR-Q, please add this where necessary.",
    question_type: 'text',
    questionnaire_id: questionnaire.id,
    position: 14
  },
  {
    content: "Any additional comment",
    question_type: 'text',
    questionnaire_id: questionnaire.id,
    position: 15
  },
  {
    content: "Has your child participated in any of the following events? If so please tick anyone of the boxes below and inform us of their personal best time(s) or height. If you are unsure of your child's personal best time/height, please leave this blank.",
    question_type: 'multiple',
    questionnaire_id: questionnaire.id,
    options: [
      "Long jump", 'Triple jump', "High jump", "Shot put", "Discus",
      "Javelin", "Hammer", "Pole vault", "60m", "60m hurdles",
      "75m", "100m", "100m hurdles", "110m hurdles", "150m",
      "200m", "300m", "400m", "800m", "1500m"
    ],
    position: 16
  },
  {
    content: "Where applicable please add times or heights based on the above",
    question_type: 'text',
    questionnaire_id: questionnaire.id,
    position: 17
  },
  {
    content: "Does your child participate in any other sport(s) not listed above?",
    question_type: 'text',
    questionnaire_id: questionnaire.id,
    position: 18
  },
  {
    content: "In the unlikely event of an emergency, where the parent/guardian cannot be contacted, I hereby give permission for my child to receive medical treatment/first aid from a qualified member of staff.",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: %w[Yes No],
    position: 19
  },
  {
    content: "I, The parent/guardian/carer give permission for my child to leave the DCPA session unaccompanied. I have discussed with my child their journey and take full responsible for my child’s safety when travelling home from the DCPA session.\n\nIf you highlight the Yes box, this indicates you give permission for your child to make their own way home.\n\nIf you highlight the No box, this indicates your child won't make their own way home and a parent/guardian/carer will pick them up.",
    question_type: 'radio',
    questionnaire_id: questionnaire.id,
    options: %w[Yes No],
    position: 20
  }



]

qs = Question.all

if qs.empty?

  questions_data.each do |question_data|
    Question.create!(question_data)
  end

end

# puts "created"
# 
#
## db/seeds.rb

# Group Training Packages
TrainingPackage.create!(
  name: '1 session a week',
  description: '1 training session per week, billed monthly.',
  features: '["Access to group training", "Weekly guidance and support"]',
  price: 38.00,
  duration_in_days: 30,  # Assuming 1 month = 30 days
  package_type: 'group_training',
  training_type: 'group_training',
  duration: 'month',
  status: 'active'
)

TrainingPackage.create!(
  name: '2 sessions a week',
  description: '2 training sessions per week, billed monthly.',
  features: '["Access to group training", "Weekly guidance and support"]',
  price: 81.00,
  duration_in_days: 30,
  package_type: 'group_training',
  training_type: 'group_training',
  duration: 'month',
  status: 'active'
)

TrainingPackage.create!(
  name: '3 sessions a week',
  description: '3 training sessions per week, billed monthly.',
  features: '["Access to group training", "Weekly guidance and support"]',
  price: 124.00,
  duration_in_days: 30,
  package_type: 'group_training',
  training_type: 'group_training',
  duration: 'month',
  status: 'active'
)