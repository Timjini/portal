import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['level']

  connect() {
    this.currentIndex = 0
    this.showLevel(this.currentIndex)
  }

  prev() {
    this.currentIndex =
      this.currentIndex === 0
        ? this.levelTargets.length - 1
        : this.currentIndex - 1
    this.showLevel(this.currentIndex)
  }

  next() {
    this.currentIndex =
      this.currentIndex === this.levelTargets.length - 1
        ? 0
        : this.currentIndex + 1
    this.showLevel(this.currentIndex)
  }

  showLevel(index) {
    this.levelTargets.forEach((el, i) => {
      el.classList.toggle('hidden', i !== index)
      el.classList.toggle('block', i === index)
    })
  }
}
