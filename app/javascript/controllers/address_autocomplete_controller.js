import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.loadGoogleMapsApi()
      .then(() => this.initAutocomplete())
      .catch((error) => console.error("Google Maps API failed to load:", error))
  }

  loadGoogleMapsApi() {
    return new Promise((resolve, reject) => {
      if (typeof google !== 'undefined' && google.maps && google.maps.places) {
        return resolve();
      }
      const googleMapsApiKey = 'AIzaSyBy4DFNj6Iu0nbitmxC9t0VwPbq2XebsMc';
      const script = document.createElement("script");
      script.src = `https://maps.googleapis.com/maps/api/js?key=${googleMapsApiKey}&libraries=places`;
      script.onload = () => resolve();
      script.onerror = () => reject(new Error("Google Maps API failed to load"));

      document.head.appendChild(script);
    });
  }

  initAutocomplete() {
    if (typeof google === 'undefined' || !google.maps || !google.maps.places) {
      console.error('Google Maps API not loaded');
      return;
    }

    this.autocomplete = new google.maps.places.Autocomplete(
      this.inputTarget,
      {
        types: ['geocode'],
        fields: ['address_components', 'formatted_address'],
      }
    );

    this.autocomplete.addListener('place_changed', () => {
      this.placeSelected();
    });
  }

  placeSelected() {
    const place = this.autocomplete.getPlace();
    if (!place.formatted_address) {
      console.error('No address details available');
      return;
    }

    this.inputTarget.value = place.formatted_address;

    this.dispatch('selected', { 
      detail: { 
        place: place,
        address: place.formatted_address,
        components: place.address_components 
      }
    });
  }

  disconnect() {
    if (this.autocomplete) {
      google.maps.event.clearInstanceListeners(this.autocomplete);
    }
  }
}
