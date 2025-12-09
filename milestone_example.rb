# frozen_string_literal: true

[
  {
    title: 'Skills Assessment Completed',
    date: 'Today, 10:30 AM',
    description: 'Completed advanced dribbling and shooting assessment with Coach Smith. Showed significant improvement in ball control.', # rubocop:disable Layout/LineLength
    color_class: 'bg-green-500',
    bg_class: 'bg-green-50',
    icon: 'check_circle',
    badge_text: 'Completed',
    badge_bg_class: 'bg-green-100',
    badge_text_class: 'text-green-800',
    actions: [
      {
        label: 'View Full Report',
        icon: 'visibility',
        text_class: 'text-blue-600 hover:text-blue-800'
      },
      {
        label: 'Download PDF',
        icon: 'download',
        text_class: 'text-gray-600 hover:text-gray-800'
      }
    ]
  },
  {
    title: 'Injury Recovery Update',
    date: '2 weeks ago',
    description: 'Completed physiotherapy for ankle sprain. Cleared for light training with no pain reported during exercises.', # rubocop:disable Layout/LineLength
    color_class: 'bg-red-500',
    bg_class: 'bg-red-50',
    icon: 'healing',
    badge_text: 'Recovered',
    badge_bg_class: 'bg-red-100',
    badge_text_class: 'text-red-800',
    actions: [
      {
        label: 'View Recovery Plan',
        icon: 'medical_information',
        text_class: 'text-blue-600 hover:text-blue-800'
      }
    ]
  }
]
