import "@hotwired/turbo-rails"
import "@rails/actioncable"
import "./controllers"

document.addEventListener('turbo:load', function() {
  // 購入ボタンのイベントハンドラ
  const purchaseButton = document.querySelector('#purchase-button');
  if (purchaseButton) {
    purchaseButton.addEventListener('click', function(e) {
      e.preventDefault();
      // フォームを直接送信
      this.closest('form').submit();
    });
  }
});
