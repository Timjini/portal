import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="check-all"
export default class extends Controller {
  static targets = ["checkbox", "row"]
  connect() {
    console.log("targets----->", this.rowTargets);
    console.log("targets----->boxes", this.checkboxTargets);
  }

  markAllKpis(){
    this.checkboxTargets.forEach(cb => {
      console.log("box", cb)
      cb.checked = true;
    })
  }

  unmarkAllKpis() {
    this.checkboxTargets.forEach(cb => {
      cb.checked = false
    })
  }
}
