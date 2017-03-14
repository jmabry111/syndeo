$(document).ready(function() {
  $("#headcounts").hide();
});

$("#attending").change(function() {
  var value = $("#attending option:selected").text()
  if(value === "Yes") {
    $("#headcounts").show();
  } else {
    $("#headcounts").hide();
  }
});
