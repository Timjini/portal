import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "image"];
    // static classes = ["hidden"]

    connect() {
        // Attach a change event listener to the file input
        this.inputTarget.addEventListener("change", this.previewImage.bind(this));
    }

    previewImage(event) {
        const input = event.target;
        const file = input.files[0];

        if (file) {
            const reader = new FileReader();
            // this.loadingIndicatorTarget.classList.remove("hidden");
            reader.onload = (e) => {
                this.imageTarget.src = e.target.result;
                // this.loadingIndicatorTarget.style.display = "none";
            };
            reader.readAsDataURL(file);
        }
    }
}
