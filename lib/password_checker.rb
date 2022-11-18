class PasswordChecker

  def initialize(admin: false)
    @admin = admin
  end

  def length
    @admin ? 10 : 7
  end

  def check_password?(password)
    length_requirement = check_length? password
    letter_requirement = check_letter? password
    number_requirement = check_number? password
    special_requirement = check_special? password

    print_strength length_requirement, letter_requirement, number_requirement, special_requirement

    length_requirement && letter_requirement && number_requirement && special_requirement
  end

  def check_letter?(password)
    password.count("a-zA-Z") > 0 ? true : false
  end

  def check_number?(password)
    password.count("0-9") > 0 ? true : false
  end

  def check_special?(password)
    return true unless @admin
    password.match?(/[!@#$%^&*()_+{}\[\]:;'"\/\\?><.,]/)
  end

  def check_length?(password)
    password.length >= length ? true : false
  end

  def print_strength(length_requirement, letter_requirement, number_requirement, special_requirement)
    puts "Does not contain #{length} characters\n" unless length_requirement
    puts "Does not contain one letter\n" unless letter_requirement
    puts "Does not contain one number\n" unless number_requirement
    puts "Does not contain one special character\n" unless special_requirement
  end
end