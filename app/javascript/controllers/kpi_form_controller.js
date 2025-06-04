// app/javascript/controllers/kpi_form_controller.js
import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'

export default class extends Controller {
  static targets = ["form"]

  async submit(event) {
    event.preventDefault()
    
    const form = this.element
    const formData = new FormData(form)
    const kpiId = form.dataset.kpiId || '<%= @level.id %>'
    const url = `/kpis/${kpiId}`

    // Convert checklist data to an array of objects
    const checklistData = []
    form.querySelectorAll('[name^="checklist_ids"]').forEach((idInput) => {
      const titleInput = form.querySelector(`#check_list_${idInput.value}`)
      checklistData.push({
        id: idInput.value,
        title: titleInput.value
      })
    })

    // Append the JSON string to the form data
    formData.append('checklist_data', JSON.stringify(checklistData))

    try {
      const response = await fetch(url, {
        method: 'PATCH',
        body: formData,
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
          'Accept': 'application/json'
        }
      })

      const data = await response.json()

      if (data.status === 'success') {
        await Swal.fire({
          icon: 'success',
          title: 'Success!',
          text: 'KPI updated successfully!',
          confirmButtonColor: '#3085d6',
        })
        
        Turbo.visit(data.redirect_url || '/kpis')
      } else {
        throw new Error(data.message || 'Failed to update KPI')
      }
    } catch (error) {
      console.error('Error:', error)
      Swal.fire({
        icon: 'error',
        title: 'Error!',
        text: 'Failed to update KPI. Please try again.',
        confirmButtonColor: '#d33',
      })
    }
  }
}