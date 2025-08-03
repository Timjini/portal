import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'


export default class extends Controller {
  static targets = ["row", "checkbox"]

  connect() {
    // console.log("AttendanceController connected")
  }

  markAllPresent() {
    this.rowTargets.forEach(row => {
      const checkbox = row.querySelector(".attendance-checkbox")
      if (checkbox) checkbox.checked = true
    })
  }

  async submitForm(event) {
    event.preventDefault()

    const form = this.element
    const formData = new FormData(form)

    try {
      const response = await fetch(form.action, {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content
        },
        body: formData
      })

      const data = await response.json()

      if (response.ok) {
        await Swal.fire({
                  icon: 'success',
                  title: 'Success!',
                  text: data.message || "Attendance saved successfully.",
                  confirmButtonColor: '#3085d6',
                })
      } else {
        await Swal.fire({
          icon: 'error',
          title: 'Error!',
          text: data.error || "Something went wrong.",
          confirmButtonColor: '#d33',
        })
      }
    } catch (err) {
      console.error("Error submitting attendance:", err)
      await Swal.fire({
        icon: 'error',
        title: 'Error!',
        text: "An unexpected error occurred.",
        confirmButtonColor: '#d33',
      })
    }
  }
}
