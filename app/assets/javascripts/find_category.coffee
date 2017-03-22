# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/
  
$(document).on "turbolinks:load", ->
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
  response_size = $(response['categories']).size() + 1
  if response['children_count'] > 0
    $('#category_list').append(
      "<select required=required id=subcategory_#{subcategory_count} class=select_category 
      size=#{response_size}>"
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
