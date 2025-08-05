import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'

export default class extends Controller {
  static targets = ["row"]
  static values = { 
    deleteUrl: { type: String, default: '/delete_user' },
    redirectUrl: { type: String, default: '/all_accounts?page=1' }
  }

  search(event) {
    const searchTerm = event.target.value.toLowerCase()
    
    this.rowTargets.forEach(row => {
      const rowData = row.textContent.toLowerCase()
      row.style.display = rowData.includes(searchTerm) ? '' : 'none'
    })
  }

  async deleteUser(event) {
    event.preventDefault()
    const userId = event.currentTarget.dataset.userId

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
        const response = await fetch(`${this.deleteUrlValue}/${userId}`, { 
          method: 'DELETE',
          headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
            'Accept': 'text/vnd.turbo-stream.html'
          }
        })

        if (response.ok) {
          Turbo.visit(this.redirectUrlValue, { action: 'replace' })
          Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: 'User deleted successfully!',
            timer: 1500
          })
        } else {
          throw new Error('Deletion failed')
        }
      } catch (error) {
        console.error('Error during delete:', error)
        Swal.fire({
          icon: 'error',
          title: 'Oops!',
          text: 'User deletion failed. Please try again.',
        })
      }
    }
  }
}