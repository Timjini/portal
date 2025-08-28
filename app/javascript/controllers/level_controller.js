// app/javascript/controllers/level_controller.js
import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'

export default class extends Controller {
  async delete(event) {
    event.preventDefault()
    
    // Get the ID from the data attribute
    const id = this.element.dataset.id || this.element.dataset.levelIdValue
    
    if (!id) {
      console.error("No ID found for deletion")
      Swal.fire({
        icon: 'error',
        title: 'Error!',
        text: 'Cannot delete: missing ID',
      })
      return
    }

    console.log("Deleting level with ID:", id);
    
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
        const response = await fetch(`/kpis/${id}`, {
          method: 'DELETE',
          headers: {
            'Accept': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
            'Content-Type': 'application/json'
          }
        })

        if (response.ok) {
          // Remove the element from the DOM
          this.element.closest('tr').remove()
          
          Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: 'Level deleted successfully!',
            timer: 1500
          })
        } else {
          const errorData = await response.json()
          throw new Error(errorData.message || 'Deletion failed')
        }
      } catch (error) {
        Swal.fire({
          icon: 'error',
          title: 'Oops!',
          text: error.message || 'Level deletion failed. Please try again.',
        })
      }
    }
  }
}