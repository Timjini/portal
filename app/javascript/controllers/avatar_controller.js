import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "image"];

    connect() {
        // Attach a change event listener to the file input
        this.inputTarget.addEventListener("change", this.previewImage.bind(this));
    }

    previewImage(event) {
        const input = event.target;
        const file = input.files[0];

        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                this.imageTarget.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    }
}
