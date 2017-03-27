# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/
  
$(document).on "turbolinks:load", ->
  $('#select_country').change ->
    $('[id^="location_child"]').remove()
    $.ajax
      url: "/find_location"
      type: "GET" 
      data: 'location_id=' + $('#select_country option:selected').val() + ';'
      success: (response) ->
        children_count_html = $('[id^="location_child"]').size() + 1
        if response['children_count'] > 0 && response['locations'][0]['children_count'] == 0
          $('#location').append(
            "<select name=user[location_id] id=location_child_#{children_count_html} class=form-control></select>"
          )
        if response['children_count'] > 0 && response['locations'][0]['children_count'] > 0
          $('#location').append(
            "<select id=location_child_#{children_count_html} class=form-control></select>"
          )
        $("#location_child_#{children_count_html}").append($("<option></option>")
          .attr('value', '')
          .text('Выберите место проживания'))          
        $.each response['locations'], (index, value) ->  
          $("#location_child_#{children_count_html}").append($("<option></option>")
            .attr("value", value['id'])
            .text(value['name']))

  $('#ad_location_id').change ->
    if $('#ad_location_id option[value=""]')
      $('#ad_location_id option[value=""]').attr('value', 0)
    if this.value == '0'
      $('#popup_select_city').find("select").val('')
      $('#popup_select_city').modal('show')

$(document).on "click", "#popup_select_city_submit", ->
  children_count = $('[id^="location_child"]').size()
  if $('[id^="location_child"]').find(":selected").val() == ''
    value = $("#select_country").find(":selected").val()
    name  = $("#select_country").find(":selected").text()
    $('#popup_select_city').modal('hide')
    $('#ad_location_id option[selected="selected"').removeAttr('selected')
    $('#ad_location_id option:first').after($('<option />', { "value": value, "selected": "selected", text: name}))
    $('#popup_select_city').modal('hide')
    $('[id^="location_child"]').remove()
    return false
  if $("#location_child_#{children_count}").find(":selected").val() == ''
    value = $("#location_child_#{children_count-1}").find(":selected").val()
    name  = $("#location_child_#{children_count-1}").find(":selected").text()
  else
    value = $("#location_child_#{children_count}").find(":selected").val()
    name  = $("#location_child_#{children_count}").find(":selected").text()
  $('#ad_location_id option[selected="selected"').removeAttr('selected')
  $('#ad_location_id option:first').after($('<option />', { "value": value, "selected": "selected", text: name}))
  $('#popup_select_city').modal('hide')
  $('[id^="location_child"]').remove()
  return false

$(document).on 'change', '[id^="location_child"]', ->
  children_count = parseInt($('[id^="location_child"]').size())
  current_child  = parseInt($($('#' + this.id).attr('id').split('_')).last()[0])
  for i in [current_child + 1..children_count + 1]
    $("#location_child_#{i}").remove()
  $.ajax
    url: "/find_location"
    type: "GET" 
    data: 'location_id=' + $('#' + this.id).val() + ';'
    success: (response) ->
      children_count_html = $('[id^="location_child"]').size() + 1
      if response['children_count'] > 0 && response['locations'][0]['children_count'] == 0
        $('#location').append(
          "<select name=user[location_id] id=location_child_#{children_count_html} class=form-control></select>"
        )
      if response['children_count'] > 0 && response['locations'][0]['children_count'] > 0
        $('#location').append(
          "<select id=location_child_#{children_count_html} class=form-control></select>"
        )
      $("#location_child_#{children_count_html}").append($("<option></option>")
          .attr('value', '')
          .text('Выберите место проживания'))  
      $.each response['locations'], (index, value) ->
        $("#location_child_#{children_count_html}").append($("<option></option>")
          .attr("value", value['id'])
          .text(value['name']))