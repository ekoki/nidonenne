$(document).ready(function() {
  $("a.generate-link").on("click", function(e) {
    e.preventDefault();
    $.ajax({
      url: "/questions/generate",
      type: "GET",
      dataType: "script"
    });
  });
});
