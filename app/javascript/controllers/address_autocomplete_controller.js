import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]
  static values = { apiKey: String }

  connect() {
    if (!this.hasApiKeyValue) {
      console.error("Google Maps API key is missing. Please set data-address-autocomplete-api-key-value.")
      return
    }

    console.debug("Initializing address autocomplete with API key:", this.obfuscatedApiKey)
    
    this.loadGoogleMapsApi()
      .then(() => this.initAutocomplete())
      .catch(error => {
        console.error("Google Maps API failed to load:", error)
        this.dispatch('error', { detail: { error } })
      })
  }

  get obfuscatedApiKey() {
    return this.apiKeyValue ? `${this.apiKeyValue.substring(0, 6)}...${this.apiKeyValue.slice(-4)}` : 'none'
  }

  loadGoogleMapsApi() {
    return new Promise((resolve, reject) => {
      if (window.google?.maps?.places) {
        console.debug("Google Maps API already loaded")
        return resolve()
      }

      const existingScript = document.querySelector('script[src*="maps.googleapis.com"]')
      if (existingScript) {
        console.debug("Google Maps API already loading...")
        existingScript.addEventListener('load', () => resolve())
        existingScript.addEventListener('error', () => reject(new Error("Google Maps API failed to load")))
        return
      }

      const script = document.createElement("script")
      script.src = `https://maps.googleapis.com/maps/api/js?key=${this.apiKeyValue}&libraries=places&callback=googleMapsLoaded`
      script.async = true
      script.defer = true

      window.googleMapsLoaded = () => {
        delete window.googleMapsLoaded
        resolve()
      }

      script.onerror = () => {
        delete window.googleMapsLoaded
        reject(new Error("Google Maps API failed to load"))
      }

      document.head.appendChild(script)
      console.debug("Loading Google Maps API...")
    })
  }

  initAutocomplete() {
    if (!window.google?.maps?.places) {
      console.error('Google Maps API not properly loaded')
      this.dispatch('error', { detail: { error: 'API not loaded' } })
      return
    }

    try {
      this.autocomplete = new google.maps.places.Autocomplete(
        this.inputTarget,
        {
          types: ['geocode'],
          fields: ['address_components', 'formatted_address', 'geometry'],
        }
      )

      this.autocomplete.addListener('place_changed', () => this.placeSelected())
      this.dispatch('ready')
      
      console.debug("Autocomplete initialized successfully")
    } catch (error) {
      console.error('Error initializing autocomplete:', error)
      this.dispatch('error', { detail: { error } })
    }
  }

  placeSelected() {
    try {
      const place = this.autocomplete.getPlace()
      
      if (!place.formatted_address) {
        throw new Error('No address details available')
      }

      this.inputTarget.value = place.formatted_address

      this.dispatch('selected', {
        detail: {
          place: place,
          address: place.formatted_address,
          components: place.address_components,
          location: place.geometry?.location?.toJSON()
        }
      })

      console.debug("Place selected:", place)
    } catch (error) {
      console.error('Error processing selected place:', error)
      this.dispatch('error', { detail: { error } })
    }
  }

  disconnect() {
    if (this.autocomplete) {
      google.maps.event.clearInstanceListeners(this.autocomplete)
    }
    
    // clean added tag
    document.querySelectorAll('script[src*="maps.googleapis.com"]').forEach(script => {
      script.remove()
    })
    
    if (window.googleMapsLoaded) {
      delete window.googleMapsLoaded
    }
    
    console.debug("Address autocomplete controller disconnected")
  }
}