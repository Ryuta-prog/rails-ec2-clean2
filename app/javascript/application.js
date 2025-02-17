import "@hotwired/turbo-rails"
import "@rails/actioncable"  // 追加
import "./controllers"

document.addEventListener('turbo:load', function() {
    const form = document.querySelector('form');
    if (form) {
      form.addEventListener('submit', function(e) {
        const submitButton = this.querySelector('input[type="submit"]');
        submitButton.disabled = true;
      });
    }
  });
