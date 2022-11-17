require 'password_checker'

RSpec.describe PasswordChecker do
  before do
    @target = described_class.new
  end

  after do
    # Do nothing
  end

  context 'Normal passwords length check' do
    it 'false if password is less than 7 characters' do
      password = "12345a"
      result = @target.check_password(password)
      expect(result).to eq(false)
    end

    it 'true if password is == 7 characters' do
      password = "123456a"
      result = @target.check_password(password)
      expect(result).to eq(true)
    end

    it 'true if password is > 7 characters' do
      password = "1234567a"
      result = @target.check_password(password)
      expect(result).to eq(true)
    end
  end

  context 'Normal passwords character check' do
    it 'false if password does not contain letter' do
      password = "1234567"
      result = @target.check_password(password)
      expect(result).to eq(false)
    end

    it 'false if password does not contain number' do
      password = "abcdefghi"
      result = @target.check_password(password)
      expect(result).to eq(false)
    end

    it 'true if password contains both' do
      password = "1234567abc"
      result = @target.check_password(password)
      expect(result).to eq(true)
    end
  end
end
