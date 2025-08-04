// app/javascript/controllers/child_user_controller.js
import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['form', 'submitButton', 'errors']

  submit(event) {
    event.preventDefault()
    this.submitButtonTarget.disabled = true
    this.clearErrors()

    fetch(this.formTarget.action, {
      method: 'POST',
      headers: {
        Accept: 'application/json',
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      },
      body: new FormData(this.formTarget)
    })
      .then((response) => {
        if (!response.ok) throw response
        return response.json()
      })
      .then((data) => {
        if (data.status === 'success') {
          window.location.href = data.redirect || window.location.href
        } else {
          throw data
        }
      })
      .catch((error) => {
        error
          .json()
          .then((data) => {
            this.displayErrors(data.errors || ['Something went wrong'])
          })
          .catch(() => {
            this.displayErrors(['Request failed'])
          })
      })
      .finally(() => {
        this.submitButtonTarget.disabled = false
      })
  }

  clearErrors() {
    this.errorsTarget.innerHTML = ''
    this.errorsTarget.classList.add('hidden')
  }

  displayErrors(errors) {
    this.errorsTarget.innerHTML = `
      <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-4">
        ${errors.map((error) => `<p class="text-red-700">${error}</p>`).join('')}
      </div>
    `
    this.errorsTarget.classList.remove('hidden')
    this.errorsTarget.scrollIntoView({ behavior: 'smooth' })
  }
}
