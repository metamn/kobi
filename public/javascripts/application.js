// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


$(document).ready(function(){
  
  // Close flash messages on dashboard
  $('#flash .close').click(function(event) {
    $('#flash').slideUp('slow');
  });
  
  // Close flash message on dashboard after 3 sec
  $('#flash').delay(3000).slideUp('slow');
  
});


