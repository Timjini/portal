// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./main"


document.addEventListener('turbo:load', function () {
    const toggleThemeBtn = document.querySelector("#toggleThemeBtn");
    const themeTextSpan = document.querySelector(".material-symbols-outlined");

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
