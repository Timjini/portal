import { Controller } from "@hotwired/stimulus"
import SlimSelect from 'slim-select'

export default class extends Controller {
  static targets = ["select", "hidden"]
  static values = { 
    placeholder: { type: String, default: "Search for coaches..." },
    noResultsText: { type: String, default: "No coaches available" }
  }

  connect() {
    this.slimSelect = new SlimSelect({
      select: this.selectTarget,
      settings: {
        showSearch: true,
        searchText: this.noResultsTextValue,
        searchPlaceholder: this.placeholderValue,
        searchHighlight: true
      }
    })

    this.updateHiddenField()
    
    this.selectTarget.addEventListener('change', this.updateHiddenField.bind(this))
  }

  disconnect() {
    this.selectTarget.removeEventListener('change', this.updateHiddenField)
    this.slimSelect.destroy()
  }

  updateHiddenField() {
    const selectedValues = this.slimSelect.getSelected()
    this.hiddenTarget.value = selectedValues.join(',')
    console.log("Selected coach IDs:", this.hiddenTarget.value)
  }
}