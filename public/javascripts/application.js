// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Jquery + Protoype conflict solver
$j = jQuery.noConflict();

$j(document).ready(function(){

  // jqFlow
  // - on Welcome > comments
  $j("div#comments #panels").jFlow({
    slides: "#comments #items",
    width: "650px",
    height: "313px"
  });
  setTimeout('changeSlide()', 5000);
  
  // jQuery UI Accordion  
  // - for Welcome > faq
  $j("#faq #accordion").accordion();


  // Accordion effect for Categories
  // Initially close all subcats
  $j("ul#accordion li > ul").hide();
  
  // Show all subcats on click
  $j('.categories .show_all').click(function(event) {
    $j("ul#accordion li > ul").show();
  });
  
  // Toggle subcats on click
  $j('ul#accordion .toggle').click(function(event) {
    $j(this).siblings().last().toggle();
    if (jQuery.trim($j(this).html()) == "+") {
      $j(this).html("-");
      $j(this).siblings().last().addClass('border');
    } else {
      $j(this).html("+");
      $j(this).parent().removeClass('border');
    }
  });
  

  // Accordion effect for Expenses
  // Initialli close all divs
  $j("#accordion > div").hide();
  
  // Toggle div on click
  $j('#accordion h3').click(function(event) {
    $j(this).next().toggle();
  });
  
  
      
  // Close flash message on dashboard after 3 sec
  $j('#flash-top').delay(3000).slideUp('slow');
  $j('#flash-resource').delay(3000).slideUp('slow');
  
  
  
});

// For jqFlow
function changeSlide() {
    $j('.jFlowNext').click();
    setTimeout('changeSlide()', 5000);
  }
