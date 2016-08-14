module DeviseHelper
  def error_messages
    content_tag(:div, flash[:error], id: 'flash_error') if flash[:error]
    content_tag(:div, flash[:notice], id: 'flash_notice') if flash[:notice]
    content_tag(:div, flash[:alert], id: 'flash_alert') if flash[:alert]
  end
end
