require 'password_checker'

RSpec.describe PasswordChecker do
  before do
    @target = described_class.new
  end

  after do
    # Do nothing
  end

  context 'Normal passwords' do
    it 'false if password is less than 7 characters' do
      password = "123456"
      result = @target.check_password(password)
      expect(result).to eq(false)
    end

    it 'true if password is == 7 characters' do
      password = "1234567"
      result = @target.check_password(password)
      expect(result).to eq(true)
    end

    it 'true if password is > 7 characters' do
      password = "12345678"
      result = @target.check_password(password)
      expect(result).to eq(true)
    end
  end
end
