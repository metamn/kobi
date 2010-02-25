// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Jquery + Protoype conflict solver
$j = jQuery.noConflict();

$j(document).ready(function(){
  
  // Close flash messages on dashboard
  $j('#flash .close').click(function(event) {
    $j('#flash').slideUp('slow');
  });
  
  // Close flash message on dashboard after 3 sec
  $j('#flash').delay(3000).slideUp('slow');
  
});


