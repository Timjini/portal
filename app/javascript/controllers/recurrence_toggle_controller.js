import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["ruleSelect", "endContainer"]

  connect() {
    this.toggleEndContainer()
  }

  toggleEndContainer() {
    if (this.ruleSelectTarget.value === 'none') {
      this.endContainerTarget.style.display = 'none'
    } else {
      this.endContainerTarget.style.display = 'block'
    }
  }
}