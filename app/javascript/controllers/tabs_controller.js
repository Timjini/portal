import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["section"];

  connect() {
    this.hideAllSections();
    console.log("connecting");
  }

  handleClick(event) {
    event.preventDefault();
    const targetId = event.target.getAttribute("href").substring(1);
    this.hideAllSections();
    this.showSection(targetId);
    console.log("click");
  }

  hideAllSections() {
    this.sectionTargets.forEach(section => {
      console.log("hide all sections");
      section.classList.add("hidden");
    });
  }

  showSection(targetId) {
    const section = this.sectionTargets.find(section => section.id === targetId);
    if (section) {
      console.log("show section");
      section.style.display = "flex";
      section.style.flexDirection = "column";
    }
  }
}