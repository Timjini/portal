import { Controller } from "@hotwired/stimulus";
import Panzoom from "@panzoom/panzoom";

export default class extends Controller {
  static targets = ["input", "image"];
  
  connect() {
    this.inputTarget.addEventListener("change", this.previewImage.bind(this));
    
    // Initialize Panzoom after image loads
    this.imageTarget.onload = () => {
      this.initPanzoom();
    };
  }

  previewImage(event) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.imageTarget.src = e.target.result;
      };
      reader.readAsDataURL(file);
    }
  }

  initPanzoom() {
    // Create container div around the image
    const container = document.createElement('div');
    container.className = 'panzoom-container absolute inset-0 overflow-hidden rounded-full';
    
    // Wrap the image
    this.imageTarget.parentNode.insertBefore(container, this.imageTarget);
    container.appendChild(this.imageTarget);
    
    // Apply necessary styles to image
    this.imageTarget.classList.add('w-full', 'h-full', 'object-cover');
    
    // Initialize Panzoom
    this.panzoom = Panzoom(this.imageTarget, {
      contain: 'outside',
      maxScale: 3,
      startScale: 1,
      disableY: false,
      canvas: false
    });
    
    // Enable wheel zoom
    container.addEventListener('wheel', (e) => {
      e.preventDefault();
      this.panzoom.zoomWithWheel(e);
    });
  }
}