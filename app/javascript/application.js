// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./main"


document.addEventListener('turbo:load', function () {
    const toggleThemeBtn = document.querySelector("#toggleThemeBtn");
    const themeTextSpan = document.querySelector(".theme_icon");

    // Function to set theme and save it to a cookie
    function setTheme(theme) {
        document.documentElement.setAttribute('data-theme', theme);
        document.cookie = `theme=${theme}; expires=Fri, 31 Dec 9999 23:59:59 GMT; path=/`;
        // Update the span content based on the theme
        themeTextSpan.textContent = theme === 'dark' ? 'dark_mode' : 'light_mode';
    }

    // Check if a theme preference exists in cookies
    const savedTheme = document.cookie.split('; ').find(row => row.startsWith('theme='));
    if (savedTheme) {
        const theme = savedTheme.split('=')[1];
        setTheme(theme);
    }

    // Toggle theme on button click and save the preference to a cookie
    toggleThemeBtn.addEventListener('click', function (event) {
        const currentTheme = document.documentElement.getAttribute("data-theme");
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        setTheme(newTheme);
    });
});



document.addEventListener('turbo:load',function() {
    const searchInput = document.getElementById('user-search');
    console.log(searchInput);
    const userIdInput = document.getElementById('user-id');
    const suggestionsContainer = document.getElementById('suggestions-container');

    searchInput.addEventListener('input', function() {
        const term = searchInput.value;

        // Clear suggestions if the search term is empty
        if (term === '') {
            suggestionsContainer.innerHTML = '';
            return;
        }

        // Make an AJAX request to the autocomplete endpoint
        fetch(`/athlete_users/autocomplete?term=${term}`)
            .then(response => response.json())
            .then(data => {
                console.log(data);
                // Clear previous results
                suggestionsContainer.innerHTML = '';

                // Display autocomplete suggestions
                if (data.length > 0) {
                    data.forEach(user => {
                        const suggestionDiv = document.createElement('div');
                        suggestionDiv.classList.add('suggestions-box');
                        suggestionDiv.textContent = `${user.first_name} - ${user.last_name}`;
                        suggestionDiv.setAttribute('data-user-id', user.id);
                        suggestionDiv.addEventListener('click', function() {
                            // Set the selected user's information inside the search box
                            searchInput.value = `${user.first_name} - ${user.last_name}`;
                            // Set the selected user's ID to the hidden input field
                            userIdInput.value = user.id;

                            if (user.id !== null) {
                                const userId = user.id;
                                fetch(`/users/${userId}`)
                                    .then(response => response.json())
                                    .then(userData => {
                                        console.log(userData);
                                        const usernameInput = document.getElementById('user-username');
                                        // const userEmail = document.getElementById('user-email');
                                        const userFirstName = document.getElementById('user-firstName');
                                        const userLastName = document.getElementById('user-lastName');

                                        // usernameInput.placeholder = userData.username;
                                        // usernameInput.value = userData.username;
                                        // userEmail.placeholder = userData.email;
                                        // userEmail.value = userData.email;
                                        // userFirstName.placeholder = userData.first_name;
                                        // userFirstName.value = userData.first_name;
                                        // userLastName.placeholder = userData.last_name;
                                        // userLastName.value = userData.last_name;
                                    })
                                    .catch(error => {
                                        console.error('Error:', error);
                                    });
                            }
                            // Clear the suggestions container after selecting a user
                            suggestionsContainer.innerHTML = '';
                        });
                        suggestionsContainer.appendChild(suggestionDiv);
                    });
                } else {
                    // If there are no suggestions, display a message
                    const noResultsDiv = document.createElement('div');
                    noResultsDiv.textContent = 'No matching users found.';
                    suggestionsContainer.appendChild(noResultsDiv);
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    });
});


  // Add the checked function
  function checkedItem(checklistId) {
    console.log(checklistId);
}

// Inside your JavaScript file or script tag
document.addEventListener('turbo:load', () => {
    const buttons = document.querySelectorAll('[data-accordion-target]');
  
    buttons.forEach(button => {
      button.addEventListener('click', () => {
        const accordionBodyId = button.getAttribute('data-accordion-target');
        const accordionFrame = document.getElementById('accordion-frame');
        const accordionBody = accordionFrame.querySelector(accordionBodyId);
  
        if (accordionBody) {
          const isExpanded = accordionBody.getAttribute('aria-expanded') === 'true';
  
          // Toggle the aria-expanded attribute
          accordionBody.setAttribute('aria-expanded', !isExpanded);
  
          // Toggle the hidden class to show/hide the accordion body
          accordionBody.classList.toggle('hidden');
  
          // Rotate the accordion icon based on the expanded state
          const accordionIcon = button.querySelector('[data-accordion-icon]');
          if (accordionIcon) {
            accordionIcon.classList.toggle('rotate-180', !isExpanded);
          }
        }
      });
    });
   
  });
  

//   new turbo frame id checklist

document.addEventListener('turbo:load', () => {
    const checkboxFrame = document.getElementById('checkbox-frame');
  
    // Use querySelectorAll to get all checkboxes within the checkbox-frame
    const checkboxes = checkboxFrame.querySelectorAll('[data-checkbox-target]');
  
    checkboxes.forEach(checkbox => {
      checkbox.addEventListener('click', () => {
        console.log('Checkbox clicked:', checkbox.checked);
        // You can perform additional actions when a checkbox is clicked
      });
    });
  });
  
