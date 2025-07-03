import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "bar1", "bar2", "bar3"]

  toggle() {
    this.menuTarget.classList.toggle("translate-x-full")
    this.menuTarget.classList.toggle("translate-x-0")

    // Animate hamburger icon
    this.bar1Target.classList.toggle("transform")
    this.bar1Target.classList.toggle("rotate-45")
    this.bar1Target.classList.toggle("translate-y-2.5")

    this.bar2Target.classList.toggle("opacity-0")

    this.bar3Target.classList.toggle("transform")
    this.bar3Target.classList.toggle("-rotate-45")
    this.bar3Target.classList.toggle("-translate-y-2.5")
  }

  close() {
    this.menuTarget.classList.add("translate-x-full")
    this.menuTarget.classList.remove("translate-x-0")

    // Reset hamburger icon
    this.bar1Target.classList.remove("rotate-45", "translate-y-2.5")
    this.bar2Target.classList.remove("opacity-0")
    this.bar3Target.classList.remove("-rotate-45", "-translate-y-2.5")
  }
}