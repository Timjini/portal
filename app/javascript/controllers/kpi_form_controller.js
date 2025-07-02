// app/javascript/controllers/kpi_form_controller.js
import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'

export default class extends Controller {
  static values = { kpiId: String }

  connect() {
    console.log('KPI Form Controller Initialized')
  }

  async submit(event) {
    event.preventDefault()
    
    const form = event.currentTarget
    const formData = new FormData(form)
    const kpiId = this.kpiIdValue

    if (!kpiId) {
      console.error('Missing KPI ID')
      Swal.fire({
        icon: 'error',
        title: 'Error!',
        text: 'Missing KPI ID',
        confirmButtonColor: '#d33',
      })
      return
    }

    // Convert checklist data to an array of objects
    const checklistData = Array.from(form.querySelectorAll('[name="checklist_ids[]"]')).map((idInput) => {
      const titleInput = form.querySelector(`#check_list_${idInput.value}`)
      return {
        id: idInput.value,
        title: titleInput?.value || ''
      }
    })

    formData.append('checklist_data', JSON.stringify(checklistData))

    try {
      const response = await fetch(`/kpis/${kpiId}/edit`, {
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
        text: error.message || 'Failed to update KPI. Please try again.',
        confirmButtonColor: '#d33',
      })
    }
  }
}