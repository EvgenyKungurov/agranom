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
    $('#selected_category').val(this.value)
    $.ajax
      url: "find_category"
      type: "GET" 
      data: 'category_id=' + $('#ad_category_id option:selected').val() + ';'
      success: (response) ->
        subcategory_count = $('.select_category').size()
        $('[id^="subcategory"]').remove()
        $('#category_list').append(
          "<select required=required id=subcategory_#{subcategory_count} class=select_category 
          size=#{subcategory_count}>"
        ) 
        $.each response['categories'], (index, value) -> 
          $("#subcategory_#{subcategory_count}").append($("<option></option>")
            .attr("value", value['id'])
            .text(value['name']))

  $(document).on 'change', '[id^="subcategory"]', ->
    category_id = this.id
    subcategory_count = $('.select_category').size() + 1
    selected_category = $('#' + category_id + ' option:selected').val()
    $('#selected_category').val(selected_category)
    $.ajax
      url: "find_category"
      type: "GET" 
      data: 'category_id=' + $('#' + category_id + ' option:selected').val() + ';'
      success: (response) ->
        response_id = $(response['categories'])[0].id.toString()
        response_size = $(response['categories']).size()
        find_exist_category_sublist = $('.select_category').last().find('option[value="' + response_id + '"]').val() != response_id
        if $('.select_category').last().attr('id') != category_id
          $('.select_category').last().remove()
        if response_size > 0 && selected_category != response_id && find_exist_category_sublist
            $('#category_list').append(
              "<select required=required id=subcategory_#{subcategory_count} class=select_category 
              size=#{response_size + 1}>"
            )  
            $.each response['categories'], (index, value) -> 
              $("#subcategory_#{subcategory_count}").append($("<option></option>")
                .attr("value", value['id'])
                .text(value['name']))