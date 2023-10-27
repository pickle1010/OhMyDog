// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
//= require flatpickr
//= require flatpickr/plugins/confirmDate/confirmDate

document.addEventListener('DOMContentLoaded', function() {
    flatpickr('.your-selector', {
      enableTime: true,
      plugins: [
        new confirmDatePlugin({})
      ]
    })
  })