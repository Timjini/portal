import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["row"]

  connect() {
    this.rowTargets.forEach(row => {
      const checkbox = row.querySelector('.attendance-checkbox')
      const timeInput = row.querySelector('.time-input')
      const notesTextarea = row.querySelector('.notes-container textarea')

      checkbox.addEventListener('change', () => {
        const checked = checkbox.checked
        timeInput.classList.toggle('hidden', !checked)
        notesTextarea.classList.toggle('hidden', !checked)

        if (checked && !timeInput.value) {
          const now = new Date()
          timeInput.value = now.toTimeString().slice(0, 5)
        }
      })

      // Trigger initial state
      checkbox.dispatchEvent(new Event('change'))
    })
  }

  submit() {
    const data = this.rowTargets.map(row => {
      return {
        user_id: row.dataset.userId,
        present: row.querySelector('.attendance-checkbox').checked,
        time: row.querySelector('.time-input').value,
        notes: row.querySelector('.notes-container textarea').value
      }
    })

    fetch("/attendances", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({ attendance: data })
    }).then(response => {
      if (response.ok) {
        alert("Attendance saved successfully.")
      } else {
        alert("Failed to save attendance.")
      }
    })
  }
}
