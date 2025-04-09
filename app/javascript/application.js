// Entry point for the build script in your package.json
import '@hotwired/turbo-rails'
import './controllers'
import './main'
import 'cropperjs';
import '@panzoom/panzoom'


// Dark Mode
document.addEventListener('turbo:load', function () {
  const toggleThemeBtn = document.querySelector('#toggleThemeBtn')
  const themeTextSpan = document.querySelector('.theme_icon')

  function setTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme)
    document.cookie = `theme=${theme}; expires=Fri, 31 Dec 9999 23:59:59 GMT; path=/`
    themeTextSpan.textContent = theme === 'dark' ? 'dark_mode' : 'light_mode'
  }

  const savedTheme = document.cookie
    .split('; ')
    .find((row) => row.startsWith('theme='))
  if (savedTheme) {
    const theme = savedTheme.split('=')[1]
    setTheme(theme)
  }

  toggleThemeBtn.addEventListener('click', function (event) {
    const currentTheme = document.documentElement.getAttribute('data-theme')
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark'
    setTheme(newTheme)
  })
})

// Athlete Search Function
document.addEventListener('turbo:load', function () {
  const searchInput = document.getElementById('user-search')
  const userIdInput = document.getElementById('user-id')
  const suggestionsContainer = document.getElementById('suggestions-container')

  searchInput.addEventListener('input', function () {
    const term = searchInput.value

    if (term === '') {
      suggestionsContainer.innerHTML = ''
      return
    }

    fetch(`/athlete_users/autocomplete?term=${term}`)
      .then((response) => response.json())
      .then((data) => {
        console.log(data)
        // Clear previous results
        suggestionsContainer.innerHTML = ''

        if (data.length > 0) {
          data.forEach((user) => {
            const suggestionDiv = document.createElement('div')
            suggestionDiv.classList.add('suggestions-box')
            suggestionDiv.textContent = `${user.first_name} - ${user.last_name}`
            suggestionDiv.setAttribute('data-user-id', user.id)
            suggestionDiv.addEventListener('click', function () {
              searchInput.value = `${user.first_name} - ${user.last_name}`
              userIdInput.value = user.id

              if (user.id !== null) {
                const userId = user.id
                fetch(`/users/${userId}`)
                  .then((response) => response.json())
                  .then((userData) => {
                    console.log(userData)
                    const usernameInput =
                      document.getElementById('user-username')
                    // const userEmail = document.getElementById('user-email');
                    const userFirstName =
                      document.getElementById('user-firstName')
                    const userLastName =
                      document.getElementById('user-lastName')

                    // usernameInput.placeholder = userData.username;
                    // usernameInput.value = userData.username;
                    // userEmail.placeholder = userData.email;
                    // userEmail.value = userData.email;
                    // userFirstName.placeholder = userData.first_name;
                    // userFirstName.value = userData.first_name;
                    // userLastName.placeholder = userData.last_name;
                    // userLastName.value = userData.last_name;
                  })
                  .catch((error) => {
                    console.error('Error:', error)
                  })
              }
              suggestionsContainer.innerHTML = ''
            })
            suggestionsContainer.appendChild(suggestionDiv)
          })
        } else {
          const noResultsDiv = document.createElement('div')
          noResultsDiv.textContent = 'No matching users found.'
          suggestionsContainer.appendChild(noResultsDiv)
        }
      })
      .catch((error) => {
        console.error('Error:', error)
      })
  })
})

function checkedItem(checklistId) {
  console.log(checklistId)
}

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

// Password view
// document.addEventListener('turbo:load', () => {
//   const passwordInput = document.getElementById('password')
//   const eyeIcon = document.querySelector('.eye-icon')

//   if (passwordInput && eyeIcon) {
//     eyeIcon.addEventListener('click', () => {
//       console.log('clicked')
//       if (passwordInput.type === 'password') {
//         passwordInput.type = 'text'
//       } else {
//         passwordInput.type = 'password'
//       }
//     })
//   }
// })

document.addEventListener('turbo:load', () => {
  // console.log('here')
})


// Adding KPI
document.addEventListener('turbo:load', addKpi)
