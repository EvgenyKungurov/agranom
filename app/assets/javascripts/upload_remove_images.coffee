$(document).on "turbolinks:load", ->
  $('#new_photo').dropzone
    maxFilesize: 10
    acceptedFiles: ".jpeg,.jpg,.png,.gif,.JPEG,.JPG,.PNG,.GIF,"
    paramName: 'photo[image]'
    addRemoveLinks: true
    success: (file, response) ->
      $(file.previewTemplate).find('.dz-remove').attr 'id', response.photo_id
      $(file.previewElement).addClass 'dz-success'
      if $('.dz-error-message span').is(':empty')
        id = $(file.previewTemplate).find('.dz-remove').attr('id')
         # Remove default links after get image id         
        $(file.previewTemplate).find('.dz-remove').remove()
        # Wrap default previewTemplate custom div to fix css click element
        $(file.previewTemplate).wrap('<div class="profile-ad-images" id=image-id-' + id + '>' + '</div')
        # Add remove button to wrap Template
        $('#image-id-' + id).append('<a class="dz-remove" id="dz-remove-' + id + '"' + 'onclick="removeImage(' + id + ')"' + 'href="javascript:void(0)">Удалить</a>')    
        # Add id images to hidden field
        $('#uploaded_images').val($('#uploaded_images').val() + id + ',')
      return
    @removeImage = (id = null) ->
      if id == null
        return $('#dz-remove-null').parent().remove()
      else
        $.ajax
          type: 'DELETE'
          url: '/photos/' + id
          success: (data) ->
            console.log data.message
            return
        return $('#dz-remove-' + id).parent().remove()
  return