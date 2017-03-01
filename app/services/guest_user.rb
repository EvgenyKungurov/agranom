class GuestUser
  def email
    'guest@example.com'
  end

  def profile
    Profile.none
  end
end
