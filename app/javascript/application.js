// Entry point for the build script in your package.json
import '@hotwired/turbo-rails'
import './controllers'
import './main'
import 'cropperjs';
import '@panzoom/panzoom'
import 'fullcalendar';


// KPI Accordion
document.addEventListener('turbo:load', () => {
  const buttons = document.querySelectorAll('[data-accordion-target]')

  buttons.forEach((button) => {
    button.addEventListener('click', () => {
      const accordionBodyId = button.getAttribute('data-accordion-target')
      const accordionFrame = document.getElementById('accordion-frame')
      const accordionBody = accordionFrame.querySelector(accordionBodyId)

      if (accordionBody) {
        const isExpanded =
          accordionBody.getAttribute('aria-expanded') === 'true'
          accordionBody.setAttribute('aria-expanded', !isExpanded)
          accordionBody.classList.toggle('hidden')
          
        const accordionIcon = button.querySelector('[data-accordion-icon]')
        if (accordionIcon) {
          accordionIcon.classList.toggle('rotate-180', !isExpanded)
        }
      }
    })
  })
})

 
// Model window
function addKpi() {
  const modalFrame = document.getElementById('modal-frame')
  const modalOpenButtons = document.querySelectorAll('[data-modal-target]')
  const modalCloseButtons = document.querySelectorAll('[data-modal-close]')
  const modal = document.getElementById('myModal')
  const closeBtn = document.getElementsByClassName('close')[0]

  function closeModal() {
    modal.style.display = 'none'
  }

  function showModal() {
    modal.style.display = 'block'
  }

  function handleModalClose(event) {
    if (event.target === modal) {
      closeModal()
    }
  }

  function initializeModal() {
    showModal()

    closeBtn.onclick = closeModal

    window.onclick = handleModalClose
  }

  modalOpenButtons.forEach((button) => {
    button.addEventListener('click', () => {
      const modalId = button.getAttribute('data-modal-target')
      const modalElement = modalFrame.querySelector(modalId)

      if (modalElement) {
        modalElement.classList.remove('hidden')
        initializeModal()
      }
    })
  })
}

// Adding KPI
document.addEventListener('turbo:load', addKpi)
