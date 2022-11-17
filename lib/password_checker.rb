class PasswordChecker

  def check_password(password)
    if password.length >= 7
      true
    else
      false
    end
  end
end