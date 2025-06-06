// app/javascript/controllers/dates_controller.js
import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['container']

  connect() {
    console.log('Dates controller connected')
  }

  add(event) {
    event.preventDefault()
    console.log('Add button clicked')

    const today = new Date()
    const dateString = today.toISOString().split('T')[0]

    const newField = document.createElement('div')
    newField.className = 'flex items-center space-x-2 mt-2'
    newField.innerHTML = `
      <input type="date" 
             name="dcpa_event[dates][]" 
             value="${dateString}"
             class="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block p-2.5 ">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
        </svg>
      </button>
    `

    this.containerTarget.appendChild(newField)
  }

  remove(event) {
    event.preventDefault()
    console.log('Remove button clicked') // Verify this appears when clicking

    // Only remove if there's more than one date field
    if (this.containerTarget.children.length > 1) {
      event.target.closest('div').remove()
    } else {
      console.warn('At least one date field must remain')
    }
  }
}
