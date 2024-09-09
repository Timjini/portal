import { Controller } from "@hotwired/stimulus"
// import { debounce } from "lodash"

export default class extends Controller {
  static targets = ["input", "list"]

  connect() {
    this.filter = debounce(this.filter.bind(this), 300)
    this.showList()
  }

  filter() {
    const query = this.inputTarget.value.toLowerCase()
    const items = this.listTarget.querySelectorAll("li")

    items.forEach(item => {
      const name = item.textContent.toLowerCase()
      if (name.includes(query)) {
        item.classList.remove("hidden")
      } else {
        item.classList.add("hidden")
      }
    })

    this.showList()
  }

  showList() {
    const hasVisibleItems = [...this.listTarget.querySelectorAll("li")].some(item => !item.classList.contains("hidden"))
    this.listTarget.classList.toggle("hidden", !hasVisibleItems)
  }

  select(event) {
    const userId = event.target.dataset.id
    console.log(`User selected: ${userId}`)
  }
}
