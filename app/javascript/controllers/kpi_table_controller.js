// app/javascript/controllers/kpi_table_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["row"]

  search(event) {
    const searchTerm = event.target.value.toLowerCase()
    
    this.rowTargets.forEach(row => {
      const rowData = row.textContent.toLowerCase()
      row.style.display = rowData.includes(searchTerm) ? '' : 'none'
    })
  }
}