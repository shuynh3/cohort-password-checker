class PasswordChecker
  attr_accessor :password

  def initialize(admin: false, password: nil)
    @admin = admin
    @password = password
  end

  def length
    @admin ? 10 : 7
  end

  def check_password?
    length_requirement = check_length?
    letter_requirement = check_letter?
    number_requirement = check_number?
    special_requirement = check_special?

    print_strength length_requirement, letter_requirement, number_requirement, special_requirement

    length_requirement && letter_requirement && number_requirement && special_requirement
  end

  def check_letter?
    password.count("a-zA-Z") > 0 ? true : false
  end

  def check_number?
    password.count("0-9") > 0 ? true : false
  end

  def check_special?
    return true unless @admin
    password.match?(/[!@#$%^&*()_+{}\[\]:;'"\/\\?><.,]/)
  end

  def check_length?
    password.length >= length ? true : false
  end

  def print_strength(length_requirement, letter_requirement, number_requirement, special_requirement)
    puts "Does not contain #{length} characters\n" unless length_requirement
    puts "Does not contain one letter\n" unless letter_requirement
    puts "Does not contain one number\n" unless number_requirement
    puts "Does not contain one special character\n" unless special_requirement
  end
end