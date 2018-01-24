$(document).keyup(function(event) {
  if (($("#password").is(":focus") || $("#nameSave").is(":focus"))   && (event.keyCode == 13)) {
    $("#goButton").click();
  }
});
