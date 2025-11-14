import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['card']

  connect() {
    this.activeCategory = null
  }

  filter(event) {
    const category = event.currentTarget.dataset.category

    // Toggle active button class
    this.element.querySelectorAll('button[data-category]').forEach((btn) => {
      btn.classList.remove('bg-blue-600', 'text-white')
      btn.classList.add('bg-gray-100', 'text-gray-700')
    })

    event.currentTarget.classList.remove('bg-gray-100', 'text-gray-700')
    event.currentTarget.classList.add('bg-blue-600', 'text-white')

    // Show/hide level cards
    this.cardTargets.forEach((card) => {
      card.style.display = card.dataset.category === category ? 'block' : 'none'
    })
  }
}
