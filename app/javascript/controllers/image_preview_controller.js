import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['preview', 'input', 'defaultPreview']

  connect() {
    console.log('Image preview controller connected')
  }

  displayPreview(event) {
    const file = event.target.files[0]
    if (file) {
      const reader = new FileReader()

      reader.onload = (e) => {
        this.previewTarget.src = e.target.result
        this.previewTarget.classList.remove('hidden')
        if (this.hasDefaultPreviewTarget) {
          this.defaultPreviewTarget.classList.add('hidden')
        }
      }

      reader.readAsDataURL(file)
    }
  }
}
