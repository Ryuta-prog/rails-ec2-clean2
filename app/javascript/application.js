import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener('turbo:load', () => {
  const form = document.getElementById('checkout_form')
  if (!form) return
  form.addEventListener('submit', function() {
    const btn = this.querySelector('button[type=submit], input[type=submit]')
    if (btn) {
      btn.disabled = true
      if (btn.tagName === 'INPUT') btn.value = '処理中…'
      else btn.textContent = '処理中…'
    }
  })
})
