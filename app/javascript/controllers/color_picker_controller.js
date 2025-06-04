import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["picker", "input", "preview"]

  connect() {
    // Initialize with the current value
    this.updatePreview(this.inputTarget.value || this.pickerTarget.value)
  }

  updateFromPicker(event) {
    this.inputTarget.value = event.target.value
    this.updatePreview(event.target.value)
  }

  updateFromInput(event) {
    if (this.isValidHex(event.target.value)) {
      this.pickerTarget.value = event.target.value
      this.updatePreview(event.target.value)
    }
  }

  updatePreview(color) {
    this.previewTarget.style.backgroundColor = color
  }

  isValidHex(color) {
    return /^#[0-9A-F]{6}$/i.test(color)
  }
}