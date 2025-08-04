import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        console.log("test connected")
    }

    testAction() {
        console.log("Test action triggered")
        alert("Test action executed successfully!")
    }
}