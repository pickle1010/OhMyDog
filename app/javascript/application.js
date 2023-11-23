// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require flatpickr
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', function () {
    flatpickr('.flatpickr', {
      enableTime: false, // Para desactivar la selección de hora
      minDate: 'today' // Limitar la selección de fecha al día de hoy y posteriores
    });
  });
  
  document.addEventListener('DOMContentLoaded', function() {
    flatpickr('#date-picker', {
      disable: JSON.parse(document.querySelector('#date-picker').getAttribute('data-disable')),
      // Otros ajustes de Flatpickr, si es necesario
    });
  });
  