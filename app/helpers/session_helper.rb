module SessionHelper
  def check_permissions
    redirect_to root_path unless authenticate_user! && (current_user.has_role? :admin)
  end

  def user_phone?
    unless current_user.profile.id == current_user.profile.phone.profile_id
      redirect_to root_path
    end
  end

  def can_do_it?
    current_user&.has_role? :admin
  end
end
