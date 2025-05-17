import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  search() {
    const query = this.inputTarget.value

    fetch(`/exercises?term=${encodeURIComponent(query)}`, {
      headers: { Accept: "text/vnd.turbo-stream.html" }
    })
    .then(response => response.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
}
