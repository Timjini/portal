import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  change(event) {
    if (!event.target.value) return

    this.element.requestSubmit()
  }
}
