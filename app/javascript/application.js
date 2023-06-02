import "@hotwired/turbo-rails"
import jquery from "jquery";
window.$ = jquery;

$('.nav_toggle').on('click', function () {
  $('.nav_toggle, .nav').toggleClass('show');
});

