import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [
    'step1',
    'step2',
    'step1Indicator',
    'step2Indicator',
    'nextButton',
    'submitButton',
    'email',
    'username',
    'firstName',
    'lastName',
    'password',
    'passwordConfirmation',
    'phone',
    'address',
    'dob',
    'role',
    'emailError',
    'usernameError',
    'firstNameError',
    'lastNameError',
    'passwordError',
    'passwordConfirmationError',
    'phoneError',
    'addressError',
    'dobError',
    'roleError',
    'passwordIcon'
  ]

  connect() {
    this.currentStep = 1
    this.touchedFields = new Set()
    this.validateStep1()
  }

  // Mark field as touched and validate
  markAsTouched(event) {
    const fieldName = event.target.dataset.fieldName
    this.touchedFields.add(fieldName)
    this.validateField(fieldName)
    this.updateStepValidation()
  }

  // Validate specific field
  validateField(fieldName) {
    switch (fieldName) {
      case 'email':
        return this.validateEmail()
      case 'username':
        return this.validateUsername()
      case 'firstName':
        return this.validateFirstName()
      case 'lastName':
        return this.validateLastName()
      case 'password':
        return this.validatePassword()
      case 'passwordConfirmation':
        return this.validatePasswordConfirmation()
      case 'phone':
        return this.validatePhone()
      case 'address':
        return this.validateAddress()
      case 'dob':
        return this.validateAge()
      case 'role':
        return this.validateRole()
    }
  }

  // Update step validation based on current step
  updateStepValidation() {
    if (this.currentStep === 1) {
      this.validateStep1()
    } else {
      this.validateStep2()
    }
  }

  // Navigation between steps
  nextStep() {
    if (this.validateStep1()) {
      this.currentStep = 2
      this.step1Target.classList.add('hidden')
      this.step2Target.classList.remove('hidden')
      this.updateStepIndicators()
      this.validateStep2()
    }
  }

  prevStep() {
    this.currentStep = 1
    this.step2Target.classList.add('hidden')
    this.step1Target.classList.remove('hidden')
    this.updateStepIndicators()
  }

  updateStepIndicators() {
    if (this.currentStep === 1) {
      this.step1IndicatorTarget.classList.remove('bg-indigo-600')
      this.step1IndicatorTarget.classList.add(
        'border-indigo-600',
        'bg-white',
        'dark:bg-gray-800'
      )
      this.step2IndicatorTarget.classList.remove('bg-indigo-600', 'text-white')
      this.step2IndicatorTarget.classList.add(
        'border-gray-300',
        'dark:border-gray-600'
      )
    } else {
      this.step1IndicatorTarget.classList.remove(
        'border-indigo-600',
        'bg-white',
        'dark:bg-gray-800'
      )
      this.step1IndicatorTarget.classList.add('bg-indigo-600', 'text-white')
      this.step2IndicatorTarget.classList.remove(
        'border-gray-300',
        'dark:border-gray-600'
      )
      this.step2IndicatorTarget.classList.add('bg-indigo-600', 'text-white')
    }
  }

  // Step validation
  validateStep1() {
    const isEmailValid = this.validateEmail()
    const isUsernameValid = this.validateUsername()
    const isFirstNameValid = this.validateFirstName()
    const isLastNameValid = this.validateLastName()
    const isPasswordValid = this.validatePassword()
    const isPasswordConfirmationValid = this.validatePasswordConfirmation()

    const isValid =
      isEmailValid &&
      isUsernameValid &&
      isFirstNameValid &&
      isLastNameValid &&
      isPasswordValid &&
      isPasswordConfirmationValid

    this.nextButtonTarget.disabled = !isValid
    return isValid
  }

  validateStep2() {
    const isPhoneValid = this.validatePhone()
    const isAddressValid = this.validateAddress()
    const isDobValid = this.validateAge()
    const isRoleValid = this.validateRole()

    const isValid = isPhoneValid && isAddressValid && isDobValid && isRoleValid

    this.submitButtonTarget.disabled = !isValid
    return isValid
  }

  // Field validations
  validateEmail() {
    const email = this.emailTarget.value.trim()
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

    if (!this.touchedFields.has('email')) {
      this.hideError(this.emailErrorTarget)
      return false
    }

    if (!email) {
      this.showError(this.emailErrorTarget, 'Email is required')
      return false
    }

    if (!emailRegex.test(email)) {
      this.showError(this.emailErrorTarget, 'Please enter a valid email')
      return false
    }

    this.hideError(this.emailErrorTarget)
    return true
  }

  validateUsername() {
    const username = this.usernameTarget.value.trim()

    if (!this.touchedFields.has('username')) {
      this.hideError(this.usernameErrorTarget)
      return false
    }

    if (!username) {
      this.showError(this.usernameErrorTarget, 'Username is required')
      return false
    }

    if (username.length < 3) {
      this.showError(
        this.usernameErrorTarget,
        'Username must be at least 3 characters'
      )
      return false
    }

    this.hideError(this.usernameErrorTarget)
    return true
  }

  validateFirstName() {
    const firstName = this.firstNameTarget.value.trim()

    if (!this.touchedFields.has('firstName')) {
      this.hideError(this.firstNameErrorTarget)
      return false
    }

    if (!firstName) {
      this.showError(this.firstNameErrorTarget, 'First name is required')
      return false
    }

    this.hideError(this.firstNameErrorTarget)
    return true
  }

  validateLastName() {
    const lastName = this.lastNameTarget.value.trim()

    if (!this.touchedFields.has('lastName')) {
      this.hideError(this.lastNameErrorTarget)
      return false
    }

    if (!lastName) {
      this.showError(this.lastNameErrorTarget, 'Last name is required')
      return false
    }

    this.hideError(this.lastNameErrorTarget)
    return true
  }

  validatePassword() {
    const password = this.passwordTarget.value

    if (!this.touchedFields.has('password')) {
      this.hideError(this.passwordErrorTarget)
      return false
    }

    if (!password) {
      this.showError(this.passwordErrorTarget, 'Password is required')
      return false
    }

    if (password.length < 8) {
      this.showError(
        this.passwordErrorTarget,
        'Password must be at least 8 characters'
      )
      return false
    }

    this.hideError(this.passwordErrorTarget)

    // Also validate confirmation when password changes
    if (this.touchedFields.has('passwordConfirmation')) {
      this.validatePasswordConfirmation()
    }

    return true
  }

  validatePasswordConfirmation() {
    const password = this.passwordTarget.value
    const confirmation = this.passwordConfirmationTarget.value

    if (!this.touchedFields.has('passwordConfirmation')) {
      this.hideError(this.passwordConfirmationErrorTarget)
      return false
    }

    if (!confirmation) {
      this.showError(
        this.passwordConfirmationErrorTarget,
        'Please confirm your password'
      )
      return false
    }

    if (password !== confirmation) {
      this.showError(
        this.passwordConfirmationErrorTarget,
        "Passwords don't match"
      )
      return false
    }

    this.hideError(this.passwordConfirmationErrorTarget)
    return true
  }

  validatePhone() {
    const phone = this.phoneTarget.value.trim()
    const phoneRegex =
      /^[+]?[(]?[0-9]{1,4}[)]?[-\s.]?[0-9]{1,4}[-\s.]?[0-9]{1,6}$/im

    if (!this.touchedFields.has('phone')) {
      this.hideError(this.phoneErrorTarget)
      return false
    }

    if (!phone) {
      this.showError(this.phoneErrorTarget, 'Phone number is required')
      return false
    }

    if (!phoneRegex.test(phone)) {
      this.showError(this.phoneErrorTarget, 'Please enter a valid phone number')
      return false
    }

    this.hideError(this.phoneErrorTarget)
    return true
  }

  validateAddress() {
    const address = this.addressTarget.value.trim()

    if (!this.touchedFields.has('address')) {
      this.hideError(this.addressErrorTarget)
      return false
    }

    if (!address) {
      this.showError(this.addressErrorTarget, 'Address is required')
      return false
    }

    this.hideError(this.addressErrorTarget)
    return true
  }

  validateAge() {
    const dob = this.dobTarget.value

    if (!this.touchedFields.has('dob')) {
      this.hideError(this.dobErrorTarget)
      return false
    }

    if (!dob) {
      this.showError(this.dobErrorTarget, 'Date of birth is required')
      return false
    }

    const birthDate = new Date(dob)
    const today = new Date()
    let age = today.getFullYear() - birthDate.getFullYear()
    const monthDiff = today.getMonth() - birthDate.getMonth()

    if (
      monthDiff < 0 ||
      (monthDiff === 0 && today.getDate() < birthDate.getDate())
    ) {
      age--
    }

    if (age < 18) {
      this.showError(this.dobErrorTarget, 'You must be at least 18 years old')
      return false
    }

    this.hideError(this.dobErrorTarget)
    return true
  }

  validateRole() {
    if (!this.touchedFields.has('role')) {
      this.hideError(this.roleErrorTarget)
      return false
    }

    const roleSelected = this.roleTargets.some((radio) => radio.checked)

    if (!roleSelected) {
      this.showError(this.roleErrorTarget, 'Please select your role')
      return false
    }

    this.hideError(this.roleErrorTarget)
    return true
  }

  togglePasswordVisibility(event) {
    const fieldType = event.currentTarget.dataset.fieldType
    const passwordField = this[`${fieldType}Target`]
    const icon = event.currentTarget.querySelector('svg')

    if (passwordField.type === 'password') {
      passwordField.type = 'text'
      icon.innerHTML = `
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
      `
    } else {
      passwordField.type = 'password'
      icon.innerHTML = `
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
      `
    }
  }

  // Helper methods
  showError(element, message) {
    element.textContent = message
    element.classList.remove('hidden')
  }

  hideError(element) {
    element.classList.add('hidden')
  }
}
