import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "input"]
  static values = { url: String, field: String }

  connect() {
    if (!this.hasInputTarget) {
      this.createInputField();
    }
  }

  edit() {
    this.displayTarget.classList.add("hidden");
    this.inputTarget.classList.remove("hidden");
    this.inputTarget.focus();
  }

  save() {
    const value = this.inputTarget.value;
    this.displayTarget.textContent = value;
    this.displayTarget.classList.remove("hidden");
    this.inputTarget.classList.add("hidden");

    if (this.urlValue) {
      fetch(this.urlValue, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
        },
        body: JSON.stringify({
          athlete: { [this.fieldValue]: value }
        })
      });
    }
  }

  cancel() {
    this.displayTarget.classList.remove("hidden");
    this.inputTarget.classList.add("hidden");
    this.inputTarget.value = this.displayTarget.textContent;
  }

  createInputField() {
    const input = document.createElement("input");
    input.type = "text";
    input.value = this.displayTarget.textContent;
    input.classList.add("hidden", "text-xs", "border", "px-1", "w-full");
    input.dataset.editableFieldTarget = "input";
    this.displayTarget.after(input);
    this.inputTarget = input;
  }
}