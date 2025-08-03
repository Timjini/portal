import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="kpi-search-input"
export default class extends Controller {
  connect() {
    console.log("KpiSearchInputController connected")
  }
}
