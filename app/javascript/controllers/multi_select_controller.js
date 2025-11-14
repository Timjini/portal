import { Controller } from '@hotwired/stimulus'
import SlimSelect from 'slim-select'

export default class extends Controller {
  static targets = ['select', 'hidden']
  static values = {
    placeholder: { type: String, default: 'Search for coaches...' },
    noResultsText: { type: String, default: 'No coaches available' }
  }

  connect() {
    // Check if already initialized using data attribute
    if (this.element.dataset.slimInitialized === 'true') {
      return
    }

    this.slimSelect = new SlimSelect({
      select: this.selectTarget,
      settings: {
        showSearch: true,
        searchText: this.noResultsTextValue,
        searchPlaceholder: this.placeholderValue,
        searchHighlight: true,
        closeOnSelect: false
      }
    })

    // Mark as initialized
    this.element.dataset.slimInitialized = 'true'

    this.updateHiddenField()
    this.selectTarget.addEventListener(
      'change',
      this.updateHiddenField.bind(this)
    )
  }

  disconnect() {
    if (this.slimSelect) {
      this.selectTarget.removeEventListener('change', this.updateHiddenField)
      this.slimSelect.destroy()
      this.element.dataset.slimInitialized = 'false'
    }
  }

  updateHiddenField() {
    if (!this.slimSelect) return

    const selectedValues = this.slimSelect.getSelected()
    this.hiddenTarget.value = selectedValues.join(',')
    console.log('Selected IDs:', this.hiddenTarget.value)
  }
}
