import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['input', 'results', 'selected']
  static values = { url: String, levelId: Number }

  connect() {
    this.selectedUsers = []
  }

  search() {
    const query = this.inputTarget.value.trim()
    if (query.length === 0) {
      this.resultsTarget.innerHTML = ''
      return
    }

    fetch(this.urlValue, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("meta[name='csrf-token']")
          .content
      },
      body: JSON.stringify({ q: query, level_id: this.levelIdValue })
    })
      .then((response) => response.json())
      .then((users) => this.renderResults(users))
  }

  renderResults(users) {
    if (users.length === 0) {
      this.resultsTarget.innerHTML = `<p class="text-sm text-gray-500 mt-2">No users found</p>`
      return
    }

    this.resultsTarget.innerHTML = users
      .map(
        (user) => `
      <div class="cursor-pointer px-3 py-2 bg-white hover:bg-blue-50 rounded-lg flex items-center justify-between"
           data-action="click->user-search#select"
           data-user='${JSON.stringify(user)}'>
        <span class="text-gray-700">${user.first_name} ${user.last_name} (${user.username})</span>
        <span class="text-xs bg-blue-100 text-blue-700 px-2 py-1 rounded-lg">${user.role}</span>
      </div>
    `
      )
      .join('')
  }

  select(event) {
    const user = JSON.parse(event.currentTarget.dataset.user)

    // Avoid duplicates
    if (this.selectedUsers.some((u) => u.id === user.id)) return

    this.selectedUsers.push(user)
    this.renderSelected()
  }

  renderSelected() {
    if (this.selectedUsers.length === 0) {
      this.selectedTarget.innerHTML = `
        <div class="flex flex-col items-center justify-center py-10 text-center border border-dashed border-gray-300 rounded-lg bg-gray-50 mt-6">
          <svg class="w-10 h-10 text-gray-400 mb-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M5.121 17.804A7 7 0 1117 10h-4l1.293-1.293a1 1 0 10-1.414-1.414L10 10l2.879 2.879a1 1 0 101.414-1.414L12.414 10H17a5 5 0 10-9.879 1.804z"/>
          </svg>
          <p class="text-gray-600 font-medium">No users selected</p>
          <p class="text-sm text-gray-400">Search and pick users to assign.</p>
        </div>
      `
      return
    }

    this.selectedTarget.innerHTML = this.selectedUsers
      .map(
        (u) => `
      <div class="flex items-center justify-between bg-white p-3 rounded-xl shadow-sm mb-2">
        <div class="flex items-center space-x-3">
          <div class="w-10 h-10 rounded-full bg-gray-200 flex items-center justify-center text-gray-500 font-medium">
            ${u.first_name[0]}${u.last_name[0]}
          </div>
          <div>
            <p class="font-medium text-gray-800">${u.first_name} ${u.last_name}</p>
            <p class="text-xs text-gray-500">${u.username}</p>
          </div>
        </div>
        <button class="text-gray-400 hover:text-red-500" data-action="click->user-search#remove" data-user-id="${u.id}">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
               viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>
    `
      )
      .join('')
  }

  remove(event) {
    const userId = parseInt(event.currentTarget.dataset.userId)
    this.selectedUsers = this.selectedUsers.filter((u) => u.id !== userId)
    this.renderSelected()
  }
}
