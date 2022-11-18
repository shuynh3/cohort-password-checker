class PasswordChecker

  def initialize(admin: false)
    @admin = admin
  end

  def length
    @admin ? 10 : 7
  end

  def check_password(password)
    result = check_characters(password) && check_length(password)
    @admin ? result && check_special(password) : result
  end

  def check_characters(password)
    check_letter(password) && check_number(password)
  end

  def check_letter(password)
    password.count("a-zA-Z") > 0 ? true : false
  end

  def check_number(password)
    password.count("0-9") > 0 ? true : false
  end

  def check_special(password)
    password.match?(/[!@#$%^&*()_+{}\[\]:;'"\/\\?><.,]/)
  end

  def check_length(password)
    password.length >= length ? true : false
  end
end