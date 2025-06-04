// app/javascript/controllers/level_controller.js
import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'

export default class extends Controller {
  static values = { id: String }

  async delete(event) {
    event.preventDefault()
    
    const confirmation = await Swal.fire({
      title: "Are you sure?",
      text: "You won't be able to revert this!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, delete it!"
    })

    if (confirmation.isConfirmed) {
      try {
        console.log("Deleting level with ID:", this.idValue);
        const response = await fetch(`/kpis/${this.idValue}`, {
          method: 'DELETE',
          headers: {
            'Accept': 'text/vnd.turbo-stream.html',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
          }
        })

        if (response.ok) {
          Turbo.visit('/kpis', { action: 'replace' })
          Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: 'Level deleted successfully!',
            timer: 1500
          })
        } else {
          throw new Error('Deletion failed')
        }
      } catch (error) {
        Swal.fire({
          icon: 'error',
          title: 'Oops!',
          text: 'Level deletion failed. Please try again.',
        })
      }
    }
  }
}