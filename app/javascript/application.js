// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./main"



// autocomplete.js

document.addEventListener('DOMContentLoaded', function() {
  const searchInput = document.getElementById('user-search');
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
                      suggestionDiv.textContent = `${user.username} - ${user.email}- ${user.first_name}- ${user.last_name}`;
                      suggestionDiv.setAttribute('data-user-id', user.id);
                      suggestionDiv.addEventListener('click', function() {
                          // Set the selected user's information inside the search box
                          searchInput.value = `${user.username} - ${user.email} - ${user.first_name}-  ${user.last_name}`;
                          // Set the selected user's ID to the hidden input field
                          userIdInput.value = user.id;
                          if (!user.id !== null) {
                            const userId = user.id
                            fetch(`/users/${userId}`)
                                .then(response => response.json())
                                .then(user => {
                                  console.log(user)
                                  const usernameInput = document.getElementById('user-username');
                                  const userEmail = document.getElementById('user-email');
                                  const userFirstName = document.getElementById('user-firstName');
                                  const userLastName = document.getElementById('user-lastName');
                          
                                  usernameInput.placeholder = user.username;
                                  usernameInput.value = user.username;
                                  userEmail.placeholder = user.email;
                                  userEmail.value = user.email;
                                  userFirstName.placeholder = user.first_name;
                                  userFirstName.value = user.first_name;
                                  userLastName.placeholder = user.last_name;
                                  userLastName.value = user.last_name;

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
                  // If there are no suggestions, you can display a message
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

  // Toggle Effect 

  document.addEventListener('DOMContentLoaded', function() {
    const toggleLinks = document.querySelectorAll('.toggle-link');
    const toggleSections = document.querySelectorAll('.toggle-section');

    toggleLinks.forEach(link => {
      link.addEventListener('click', function(event) {
        event.preventDefault();

        const targetId = link.getAttribute('href').substring(1);

        toggleSections.forEach(section => {
          if (section.id === targetId) {
            section.style.display = 'flex';
            section.style.flexDirection = 'column';
          } else {
            section.style.display = 'none';
          }
        });
      });
    });
  });