import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["submit"]

    connect() {
    console.log("Stimulus: TestController connected")
    }

  loading() {
    console.log("Stimulus: loading triggered")
    this.submitTarget.disabled = true
    this.submitTarget.textContent = "Loading..."
  }

  success(event) {
    const [data, _status, _xhr] = event.detail
    this.flashMessage(data.message, "notice")
    this.reset()
  }

  error(event) {
    const [data, _status, _xhr] = event.detail
    this.flashMessage(data.message || "Something went wrong", "alert")
    this.reset()
  }

  reset() {
    this.submitTarget.disabled = false
    this.submitTarget.textContent = "Click Me"
  }

  flashMessage(message, type) {
    let flash = document.querySelector(".flash")
    if (!flash) {
      flash = document.createElement("div")
      flash.classList.add("flash", type)
      document.body.prepend(flash)
    }
    flash.textContent = message
    flash.className = `flash ${type}`
  }
}
