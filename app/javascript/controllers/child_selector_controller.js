import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = {
    url: String,
    loading: { type: Boolean, default: false }
  }

  connect() {
    console.log('Child Selector controller connected')
  }

  async selectChild(event) {
    const childId = event.target.value
    this.loadingValue = true
    this.showLoadingState()

    try {
      const response = await fetch(
        this.urlValue.replace(':child_id', childId),
        {
          method: 'POST',
          headers: {
            Accept: 'text/vnd.turbo-stream.html',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')
              .content
          },
          body: JSON.stringify({})
        }
      )

      if (response.ok) {
        const html = await response.text()
        Turbo.renderStreamMessage(html)
      } else {
        console.error('Failed to fetch child data')
      }
    } catch (error) {
      console.error('Error fetching child data:', error)
    } finally {
      this.loadingValue = false
      this.hideLoadingState()
    }
  }

  showLoadingState() {
    const timelineSection =
      document.querySelector('[data-controller="progress-timeline"]') ||
      document.querySelector('#progress-timeline')

    if (timelineSection) {
      timelineSection.innerHTML = `
        <div class="flex justify-center items-center h-40">
          <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
          <span class="ml-2 text-gray-600">Loading milestones...</span>
        </div>
      `
    }
  }

  hideLoadingState() {
    // Loading state will be replaced by Turbo Stream
  }
}
