import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step", "nextButton", "prevButton", "submitButton", "progress"]
  static values = { current: { type: Number, default: 0 }, totalSteps: Number }

  connect() {
    this.totalStepsValue = this.stepTargets.length
    this.updateProgress()
    this.showCurrentStep()
  }

  next() {
    if (this.validateCurrentStep()) {
      this.currentValue++
      this.showCurrentStep()
      this.updateProgress()
    }
  }

  prev() {
    this.currentValue--
    this.showCurrentStep()
    this.updateProgress()
  }

  showCurrentStep() {
    this.stepTargets.forEach((step, index) => {
      step.classList.toggle('hidden', index !== this.currentValue)
    })

    this.prevButtonTarget.classList.toggle('hidden', this.currentValue === 0)
    this.nextButtonTarget.classList.toggle('hidden', this.currentValue === this.totalStepsValue - 1)
    this.submitButtonTarget.classList.toggle('hidden', this.currentValue !== this.totalStepsValue - 1)
  }

  validateCurrentStep() {
    let isValid = true
    const currentStep = this.stepTargets[this.currentValue]
  
    // Validate required textareas
    const textareas = currentStep.querySelectorAll('textarea[required]')
    textareas.forEach(textarea => {
      if (!textarea.value.trim()) {
        textarea.classList.add('border-red-500')
        isValid = false
      } else {
        textarea.classList.remove('border-red-500')
      }
    })
  
    const requiredRadioNames = new Set()
    const radios = currentStep.querySelectorAll('input[type="radio"][required]')
    radios.forEach(radio => requiredRadioNames.add(radio.name))
  
    requiredRadioNames.forEach(name => {
      const group = currentStep.querySelectorAll(`input[name="${name}"]`)
      const isChecked = [...group].some(input => input.checked)
      group.forEach(input => {
        const label = currentStep.querySelector(`label[for="${input.id}"]`)
        if (!isChecked) {
          input.classList.add('border-red-500')
          if (label) label.classList.add('text-red-500')
          isValid = false
        } else {
          input.classList.remove('border-red-500')
          if (label) label.classList.remove('text-red-500')
        }
      })
    })

    if (!isValid) {
      const firstInvalid = currentStep.querySelector('.border-red-500')
      if (firstInvalid) firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' })
    }
  
    return isValid
  }

  updateProgress() {
    const progress = ((this.currentValue + 1) / this.totalStepsValue) * 100
    this.progressTarget.style.width = `${progress}%`
    this.progressTarget.setAttribute('aria-valuenow', progress)
  }
}