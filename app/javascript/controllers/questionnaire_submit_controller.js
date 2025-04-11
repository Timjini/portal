// app/javascript/controllers/questionnaire_submit_controller.js
import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'

export default class extends Controller {
  static values = { 
    submitUrl: String,
    userId: String
  }

  static targets = ["form"]

  connect() {
    console.log("form target",this.formTarget);
    this.csrfToken = document.querySelector('meta[name="csrf-token"]').content
  }

  async submit(e) {
    e.preventDefault()
    
    try {
      const answers = this.collectAnswers()
      console.log("submitted answers", answers);
      const response = await this.sendData(answers)
      const data = await response.json()

      if (data.status == 'success') {
        await this.showSuccess()
        window.location.href = '/'
      } else {
        this.showError(data.error || 'Something went wrong.')
      }
    } catch (error) {
      console.error('Submission error:', error)
      this.showError('Failed to submit the questionnaire.')
    }
  }

  collectAnswers() {
    const formData = new FormData(this.formTarget);
    const answers = [];
    const userId = this.userId;
  
    formData.forEach((value, key) => {
      const match = key.match(/answers\[(\d+)\](\[\])?/);
      if (match) {
        const questionId = match[1];
        const isMultiple = match[2] === "[]";
        
        if (isMultiple) {
          answers.push({ question_id: questionId, content: value, user_id: userId });
        } else {
          answers.push({ question_id: questionId, content: value, user_id: userId });
        }
      }
    });
  
    return answers;
  }

  async sendData(answers) {
    return fetch(this.submitUrlValue, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': this.csrfToken
      },
      body: JSON.stringify({ 
        answers: answers, 
        user_id: this.userIdValue
      })
    })
  }

  async showSuccess() {
    return Swal.fire({
      title: 'Success!',
      text: 'Your health questionnaire has been submitted.',
      icon: 'success',
      confirmButtonText: 'OK'
    })
  }

  showError(message) {
    Swal.fire({
      title: 'Error!',
      text: message,
      icon: 'error',
      confirmButtonText: 'OK'
    })
  }
}