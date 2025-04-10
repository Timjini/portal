// app/javascript/controllers/user_search_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["searchInput", "userIdInput", "suggestions", "username", "firstName", "lastName"]

  connect() {
    // Initialize with empty suggestions
    this.clearSuggestions()
  }

  search() {
    const term = this.searchInputTarget.value.trim()

    if (term === '') {
      this.clearSuggestions()
      return
    }

    this.fetchSuggestions(term)
  }

  async fetchSuggestions(term) {
    try {
      const response = await fetch(`/athlete_users/autocomplete?term=${encodeURIComponent(term)}`)
      const users = await response.json()
      
      if (users.length > 0) {
        this.displaySuggestions(users)
      } else {
        this.showNoResults()
      }
    } catch (error) {
      console.error('Error fetching suggestions:', error)
      this.showError()
    }
  }

  displaySuggestions(users) {
    this.clearSuggestions()
    
    users.forEach(user => {
      const suggestion = document.createElement('div')
      suggestion.classList.add('suggestions-box', 'cursor-pointer', 'p-2', 'hover:bg-gray-100')
      suggestion.textContent = `${user.first_name} ${user.last_name}`
      suggestion.dataset.action = "click->user-search#selectUser"
      suggestion.dataset.userId = user.id
      suggestion.dataset.user = JSON.stringify(user)
      this.suggestionsTarget.appendChild(suggestion)
    })
  }

  selectUser(event) {
    const user = JSON.parse(event.currentTarget.dataset.user)
    
    // updta search field
    this.searchInputTarget.value = `${user.first_name} ${user.last_name}`
    this.userIdInputTarget.value = user.id
    
    // update other fields if targets exist
    if (this.hasUsernameTarget) this.usernameTarget.value = user.username || ''
    if (this.hasFirstNameTarget) this.firstNameTarget.value = user.first_name || ''
    if (this.hasLastNameTarget) this.lastNameTarget.value = user.last_name || ''
    
    this.clearSuggestions()
  }

  clearSuggestions() {
    this.suggestionsTarget.innerHTML = ''
  }

  showNoResults() {
    this.clearSuggestions()
    const message = document.createElement('div')
    message.classList.add('p-2', 'text-gray-500')
    message.textContent = 'No matching users found.'
    this.suggestionsTarget.appendChild(message)
  }

  showError() {
    this.clearSuggestions()
    const message = document.createElement('div')
    message.classList.add('p-2', 'text-red-500')
    message.textContent = 'Error loading suggestions.'
    this.suggestionsTarget.appendChild(message)
  }
}