import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar"];

  toggleSidebar() {
    this.sidebarTarget.classList.toggle("-translate-x-full");
    console.log("toggle");
  }

  closeSidebar(event) {
    if (!this.sidebarTarget.contains(event.target)) {
      this.sidebarTarget.classList.add("-translate-x-full");
    }
  }
}
