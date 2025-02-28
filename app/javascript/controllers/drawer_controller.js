import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["drawer"];
  
    connect() {
      console.log("Connected to toggle_drawer controller");
    }
  
    toggleDrawer() {
      this.drawerTarget.classList.toggle("translate-x-full");
    }
  }
  