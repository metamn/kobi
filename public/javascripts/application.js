// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Jquery + Protoype conflict solver
$j = jQuery.noConflict();

$j(document).ready(function(){
  
  // Close flash messages on dashboard
  $j('#flash.top .close').click(function(event) {
    $j('#flash.top').slideUp('slow');
  });
  $j('#flash.resource .close').click(function(event) {
    $j('#flash.resource').slideUp('slow');
  });
  
  
  // Close flash message on dashboard after 3 sec
  $j('#flash.top').delay(3000).slideUp('slow');
  $j('#flash.resource').delay(3000).slideUp('slow');
  
  
  // Init accordion for expenses
  //$j(function() {
	//	$j("#accordion").accordion();
	//});

  
  // Accordion effect for Expenses
  // Initialli close all divs
  $j("#accordion > div").hide();
  
  // Toggle div on click
  $j('#accordion h3').click(function(event) {
    $j(this).next().toggle();
  });
  
});


