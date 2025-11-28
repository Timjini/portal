import { Controller } from '@hotwired/stimulus'
import Swal from 'sweetalert2'

export default class extends Controller {
  static targets = ['row', 'checkbox', 'date']

  connect() {
    this.attendanceState =
      JSON.parse(localStorage.getItem('attendanceCache')) || {}

    const cachedDate = localStorage.getItem('attendanceSelectedDate')
    if (cachedDate) {
      this.dateTarget.value = cachedDate
      this.loadDate()
    }
    this.restoreCheckboxes()
  }

  markAllPresent() {
    this.rowTargets.forEach((row) => {
      const checkbox = row.querySelector('.attendance-checkbox')
      if (checkbox) checkbox.checked = true
    })
    localStorage.setItem(
      'attendanceCache',
      JSON.stringify(this.attendanceState)
    )
  }

  restoreCheckboxes() {
    this.rowTargets.forEach((row) => {
      const userId = row.dataset.userId
      const checkbox = row.querySelector('input[type=checkbox]')
      if (this.attendanceState[userId] !== undefined) {
        checkbox.checked = this.attendanceState[userId]
      }
    })
  }

  toggleCheckbox(event) {
    const checkbox = event.target
    const userId = checkbox.closest('[data-user-id]').dataset.userId
    this.attendanceState[userId] = checkbox.checked
    localStorage.setItem(
      'attendanceCache',
      JSON.stringify(this.attendanceState)
    )
  }

  async loadDate(event) {
    const selectedDate = this.dateTarget.value

    if (!selectedDate) return

    localStorage.setItem('attendanceSelectedDate', selectedDate)

    try {
      const response = await fetch(`/attendance/fetch?date=${selectedDate}`)
      const data = await response.json()

      this.rowTargets.forEach((row) => {
        const checkbox = row.querySelector('.attendance-checkbox')
        if (checkbox) checkbox.checked = false
      })

      data.forEach((record) => {
        const row = this.rowTargets.find(
          (r) => r.dataset.userId == record.user_id
        )
        if (row) {
          const checkbox = row.querySelector('.attendance-checkbox')
          if (checkbox) checkbox.checked = record.status === 'present'
        }
      })
    } catch (error) {
      console.error('Failed to load attendance:', error)
    }
  }

  async submitForm(event) {
    event.preventDefault()
    const form = this.element

    // getting date formData
    const selectedDate = this.dateTarget.value
    const dateInput = document.createElement('input')
    dateInput.type = 'hidden'
    dateInput.name = 'attendance[attended_at]'
    dateInput.value = selectedDate
    form.appendChild(dateInput)

    Object.entries(this.attendanceState).forEach(([userId, isChecked]) => {
      const hidden = document.createElement('input')
      hidden.type = 'hidden'
      hidden.name = `attendance[users][${userId}]`
      hidden.value = isChecked ? '1' : '0'
      form.appendChild(hidden)
    })

    localStorage.removeItem('attendanceCache')
    const formData = new FormData(form)

    try {
      const response = await fetch(form.action, {
        method: 'POST',
        headers: {
          Accept: 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name=csrf-token]')
            .content
        },
        body: formData
      })

      const data = await response.json()

      if (response.ok) {
        await Swal.fire({
          icon: 'success',
          title: 'Success!',
          text: data.message || 'Attendance saved successfully.',
          confirmButtonColor: '#3085d6'
        })
      } else {
        await Swal.fire({
          icon: 'error',
          title: 'Error!',
          text: data.error || 'Something went wrong.',
          confirmButtonColor: '#d33'
        })
      }
    } catch (err) {
      console.error('Error submitting attendance:', err)
      await Swal.fire({
        icon: 'error',
        title: 'Error!',
        text: 'An unexpected error occurred.',
        confirmButtonColor: '#d33'
      })
    }
  }
}
