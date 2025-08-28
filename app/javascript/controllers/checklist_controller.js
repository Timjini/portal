import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'

export default class extends Controller {
  static targets = ["checkbox"]
  static values = {
    userId: String
  }

  connect() {
    console.log("Checklist controller connected")
  }

  handleCheckboxClick(event) {
    const checkbox = event.currentTarget
    const checklistId = checkbox.dataset.checklistId
    const completed = checkbox.checked
  
    // Show loading alert
    Swal.fire({
      title: 'Processing...',
      text: 'Please wait',
      allowOutsideClick: false,
      didOpen: () => {
        Swal.showLoading()
      }
    })
  
    const postData = {
      checklist_item: {
        checklist_id: checklistId,
        user_id: this.userIdValue,
        completed: completed
      }
    };
  
    fetch('/checklist_items', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': this.getCSRFToken()
      },
      body: JSON.stringify(postData)
    })
    .then(response => {
      if (!response.ok) throw new Error('Network error');
      return response.headers.get('Content-Type')?.includes('application/json') ? response.json() : {};
    })
    .then(data => {
      Swal.fire({
        icon: 'success',
        title: 'Success!',
        text: completed ? 'Checklist item added!' : 'Checklist item removed!',
        timer: 2000,
        showConfirmButton: false
      });
    })
    .catch(error => {
      console.error('Checklist error:', error);
      checkbox.checked = !completed
      Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: completed ? 'Failed to add checklist item.' : 'Failed to remove checklist item.'
      });
    });
  }

  getCSRFToken() {
    return document.querySelector("[name='csrf-token']").content
  }
}