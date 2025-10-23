import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['searchInput', 'results', 'selectedUsers', 'hiddenInput']
  static values = {
    searchUrl: String,
    selected: { type: Array, default: [] }
  }

  connect() {
    console.log('AthleteSearch controller connected!') // Debug log
    this.selectedValue = JSON.parse(this.hiddenInputTarget.value || '[]')
    this.renderSelectedUsers()
  }

  searchUsers() {
    const query = this.searchInputTarget.value.trim()
    console.log('Searching for:', query) // Debug log

    if (query.length < 2) {
      this.resultsTarget.innerHTML = ''
      this.resultsTarget.classList.add('hidden')
      return
    }

    fetch(`${this.searchUrlValue}?q=${encodeURIComponent(query)}`, {
      headers: {
        Accept: 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
      .then((response) => {
        if (!response.ok) {
          throw new Error('Network response was not ok')
        }
        return response.json()
      })
      .then((users) => {
        console.log('Found users:', users) // Debug log
        this.displayResults(users)
      })
      .catch((error) => {
        console.error('Search error:', error)
        this.resultsTarget.innerHTML =
          '<div class="p-3 text-red-500 text-center">Search failed</div>'
        this.resultsTarget.classList.remove('hidden')
      })
  }

  displayResults(users) {
    if (users.length === 0) {
      this.resultsTarget.innerHTML =
        '<div class="p-3 text-gray-500 text-center">No users found</div>'
      this.resultsTarget.classList.remove('hidden')
      return
    }

    this.resultsTarget.innerHTML = users
      .map(
        (user) => `
      <div class="p-3 border-b border-gray-200 hover:bg-gray-50 cursor-pointer flex justify-between items-center" 
           data-action="click->athlete-search#selectUser"
           data-user-id="${user.id}"
           data-athlete-search-user-param="${JSON.stringify(user).replace(/"/g, '&quot;')}">
        <div>
          <div class="font-medium">${user.first_name} ${user.last_name}</div>
          <div class="text-sm text-gray-500">@${user.username} • ${user.role}</div>
        </div>
        ${
          this.isSelected(user.id)
            ? '<span class="text-green-600 text-sm">✓ Selected</span>'
            : '<button class="px-3 py-1 bg-blue-600 text-white text-sm rounded hover:bg-blue-700">Select</button>'
        }
      </div>
    `
      )
      .join('')

    this.resultsTarget.classList.remove('hidden')
  }

  selectUser(event) {
    const userParam = event.currentTarget.dataset.athleteSearchUserParam
    console.log('Selecting user:', userParam) // Debug log
    const user = JSON.parse(userParam)

    if (this.isSelected(user.id)) {
      this.removeUser(user.id)
    } else {
      this.addUser(user)
    }

    this.searchInputTarget.value = ''
    this.resultsTarget.innerHTML = ''
    this.resultsTarget.classList.add('hidden')
  }

  addUser(user) {
    if (!this.isSelected(user.id)) {
      this.selectedValue.push(user)
      this.updateHiddenInput()
      this.renderSelectedUsers()
    }
  }

  removeUser(event) {
    const userId = parseInt(event.currentTarget.dataset.userId)
    this.selectedValue = this.selectedValue.filter((user) => user.id !== userId)
    this.updateHiddenInput()
    this.renderSelectedUsers()
  }

  isSelected(userId) {
    return this.selectedValue.some((user) => user.id === userId)
  }

  renderSelectedUsers() {
    if (this.selectedValue.length === 0) {
      this.selectedUsersTarget.innerHTML =
        '<div class="text-gray-500 text-center py-4">No users selected</div>'
      return
    }

    this.selectedUsersTarget.innerHTML = this.selectedValue
      .map(
        (user) => `
      <div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg border">
        <div class="flex items-center space-x-3">
          <div class="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center text-blue-600 font-medium text-sm">
            ${user.first_name[0]}${user.last_name[0]}
          </div>
          <div>
            <div class="font-medium">${user.first_name} ${user.last_name}</div>
            <div class="text-sm text-gray-500">@${user.username}</div>
          </div>
        </div>
        <button type="button" 
                class="text-red-600 hover:text-red-800 p-1"
                data-action="click->athlete-search#removeUser"
                data-user-id="${user.id}">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>
    `
      )
      .join('')
  }

  updateHiddenInput() {
    const userIds = this.selectedValue.map((user) => user.id)
    this.hiddenInputTarget.value = JSON.stringify(userIds)
    console.log('Selected user IDs:', userIds)
  }

  clearSearch() {
    setTimeout(() => {
      this.resultsTarget.innerHTML = ''
      this.resultsTarget.classList.add('hidden')
    }, 200)
  }
}
