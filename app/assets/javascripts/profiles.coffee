# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
  
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
            "<select name=user[location_id] id=location_child_#{children_count_html} class=form-control required=required></select>"
          )
        if response['children_count'] > 0 && response['locations'][0]['children_count'] > 0
          $('#location').append(
            "<select id=location_child_#{children_count_html} class=form-control required=required></select>"
          )
        $.each response['locations'], (index, value) ->
          $("#location_child_#{children_count_html}").append($("<option></option>")
            .attr('value', '')
            .text('Выберите место проживания'))
          $("#location_child_#{children_count_html}").append($("<option></option>")
            .attr("value", value['id'])
            .text(value['name']))

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
          "<select name=user[location_id] id=location_child_#{children_count_html} class=form-control required=required></select>"
        )
      if response['children_count'] > 0 && response['locations'][0]['children_count'] > 0
        $('#location').append(
          "<select id=location_child_#{children_count_html} class=form-control required=required></select>"
        )
      $.each response['locations'], (index, value) ->
        $("#location_child_#{children_count_html}").append($("<option></option>")
          .attr('value', '')
          .text('Выберите место проживания'))
        $("#location_child_#{children_count_html}").append($("<option></option>")
          .attr("value", value['id'])
          .text(value['name']))

  $('#ad_location_id').change ->
    if $('#ad_location_id option[value=""]')
      $('#ad_location_id option[value=""]').attr('value', 0)
    if this.value == '0'
      $('#popup_select_city').find("select").val('')
      $('#popup_select_city').modal('show')
  
  $('#ad_category_id').on "change", ->
    removeAttrSelected(this.id)
    assignSelectedCategory(this.value)
    addAttrSelectedToCategory(this.value)
    dumpSelectedCategory()
    $.ajax
      url: "/find_category"
      type: "GET" 
      data: 'category_id=' + $('#ad_category_id option:selected').val() + ';'
      success: (response) ->
        addSelectWithInputs(response)

  @popupSelectCity = () ->
    children_count = $('[id^="location_child"]').size()
    $('#popup_select_city').submit ->
      value = $("#location_child_#{children_count}").find(":selected").val()
      name  = $("#location_child_#{children_count}").find(":selected").text()
      $('#ad_location_id option[selected="selected"').removeAttr('selected')
      $('#email option:first').after($('<option />', { "value": value, text: 'My new option', class: 'new_address_mail' }));
      $('#ad_location_id option:first').after($('<option />', { "value": value, "selected": "selected", text: name}))
      $('#popup_select_city').modal('hide')     
      return false

$(document).on 'change', '[id^="subcategory"]', ->
  removeAttrSelected(this.id)
  addAttrSelectedToCategory(this.value)
  category_id = this.id
  selected_category = $('#' + category_id + ' option:selected').val()
  assignSelectedCategory(selected_category)
  $.ajax
    url: "/find_category"
    type: "GET" 
    data: 'category_id=' + $('#' + category_id + ' option:selected').val() + ';'
    success: (response) ->
      addSelectWithInputsToSubdomain(response, category_id)
      dumpSelectedCategory()


@assignSelectedCategory = (value) ->
  $('#selected_category').val(value)

@addAttrSelectedToCategory = (value) ->
  $('.select_category option[value=' + value + ']').attr('selected', 'selected')

@dumpSelectedCategory = () ->
  $('#category_dump').val($('#category_list').html())

@addSelectWithInputs = (response) -> 
  $('[id^="subcategory"]').remove()
  subcategory_count = $('.select_category').size()
  if response['children_count'] > 0
    $('#category_list').append(
      "<select required=required id=subcategory_#{subcategory_count} class=select_category 
      size=#{subcategory_count + 1}>"
    ) 
    $.each response['categories'], (index, value) -> 
      $("#subcategory_#{subcategory_count}").append($("<option></option>")
        .attr("value", value['id'])
        .text(value['name']))

@removeAttrSelected = (value) ->
  $('#' + value + ' option[selected="selected"').removeAttr('selected')  

@addSelectWithInputsToSubdomain = (response, category_id) ->
  response_id = $(response['categories'])[0].id.toString()
  response_size = $(response['categories']).size() + 1
  subcategory_count = $('.select_category').size()
  
  if $('.select_category').last().attr('id') != category_id
    $('.select_category').last().remove()
  if response['children_count'] > 0 && response['categories'][0]['children_count'] == 0
    
    $('#category_list').append(response
      "<select required=required id=subcategory_#{subcategory_count} class=select_category 
      size=#{response_size}>"
      )  
    $.each response['categories'], (index, value) -> 
      $("#subcategory_#{subcategory_count}").append($("<option></option>")
        .attr("value", value['id'])
        .text(value['name']))
