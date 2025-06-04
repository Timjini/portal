import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    delay: { type: Number, default: 3000 }
  }

  static targets = ["progress"]

  connect() {
    this.element.querySelector('div > div').classList.add(
      'translate-y-[-20px]', 
      'opacity-0'
    )

    setTimeout(() => {
      this.element.querySelector('div > div').classList.remove(
        'translate-y-[-20px]', 
        'opacity-0'
      )
    }, 10)

    if (this.hasProgressTarget) {
      this.progressTarget.style.width = '100%'
      this.progressTarget.style.transition = `width ${this.delayValue}ms linear`
      setTimeout(() => {
        this.progressTarget.style.width = '0%'
      }, 10)
    }

    setTimeout(() => this.hide(), this.delayValue)
  }

  hide() {
    const notification = this.element.querySelector('div > div')
    notification.classList.add(
      'translate-y-[-20px]', 
      'opacity-0'
    )
    
    setTimeout(() => {
      this.element.remove()
    }, 500)
  }
}