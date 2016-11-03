# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
  
$(document).on "turbolinks:load", ->
  $('#select_country').change ->
    $('#select_region').empty()
    $('#select_city').empty()
    
    $.ajax
      url: "find_city"
      type: "GET" 
      data: 'get_id=' + $('#select_country option:selected').val() + ';' + 
        'type_of_request=select_region' 
      dataType: "script"  

  $('#select_region').change ->
    $('#select_city').empty()
    
    $.ajax
      url: "find_city"
      type: "GET" 
      data: 'get_id=' + $('#select_region option:selected').val() + ';' + 
        'type_of_request=select_city'
      dataType: "script"