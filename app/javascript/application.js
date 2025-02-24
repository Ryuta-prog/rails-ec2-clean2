import "@hotwired/turbo-rails"
import "@rails/actioncable"
import "./controllers"

document.addEventListener('turbo:load', function() {
  const purchaseForm = document.querySelector('form');
  if (purchaseForm) {
    purchaseForm.addEventListener('submit', function(e) {
      const submitButton = this.querySelector('input[type="submit"]');
      if (submitButton) {
        submitButton.disabled = true;
        submitButton.value = "処理中...";
      }
      return true;  // フォームの送信を許可
    });
  }
});
