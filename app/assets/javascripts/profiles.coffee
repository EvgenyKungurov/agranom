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

  $('#ad_category_id').on "change", ->
    removeAttrSelected(this.id)
    assignSelectedCategory(this.value)
    addAttrSelectedToCategory(this.value)
    dumpSelectedCategory()
    $.ajax
      url: "find_category"
      type: "GET" 
      data: 'category_id=' + $('#ad_category_id option:selected').val() + ';'
      success: (response) ->
        addSelectWithInputs(response)

$(document).on 'change', '[id^="subcategory"]', ->
  removeAttrSelected(this.id)
  addAttrSelectedToCategory(this.value)
  dumpSelectedCategory()
  category_id = this.id
  subcategory_count = $('.select_category').size()
  selected_category = $('#' + category_id + ' option:selected').val()
  assignSelectedCategory(selected_category)
  $.ajax
    url: "find_category"
    type: "GET" 
    data: 'category_id=' + $('#' + category_id + ' option:selected').val() + ';'
    success: (response) ->
      addSelectWithInputsToSubdomain(response, category_id, subcategory_count)

@assignSelectedCategory = (value) ->
  $('#selected_category').val(value)

@addAttrSelectedToCategory = (value) ->
  $('.select_category option[value=' + value + ']').attr('selected', 'selected')

@dumpSelectedCategory = () ->
  $('#category_dump').val($('#category_list').html())

@addSelectWithInputs = (response) -> 
  $('[id^="subcategory"]').remove()
  subcategory_count = $('.select_category').size()
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

@addSelectWithInputsToSubdomain = (response, category_id, subcategory_count) ->
  response_id = $(response['categories'])[0].id.toString()
  response_size = $(response['categories']).size() + 1
  find_exist_category_sublist = $('.select_category').last().find('option[value="' + response_id + '"]').val() != response_id
  if $('.select_category').last().attr('id') != category_id
    $('.select_category').last().remove()
  if response_size > 0 && selected_category != response_id && find_exist_category_sublist
      $('#category_list').append(
        "<select required=required id=subcategory_#{subcategory_count} class=select_category 
        size=#{response_size}>"
      )  
      $.each response['categories'], (index, value) -> 
        $("#subcategory_#{subcategory_count}").append($("<option></option>")
          .attr("value", value['id'])
          .text(value['name']))