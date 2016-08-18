module SessionHelper
  def check_permissions
    redirect_to root_path unless authenticate_user! && (current_user.has_role? :admin)
  end

  def can_do_it?
    current_user&.has_role? :admin
  end
end
