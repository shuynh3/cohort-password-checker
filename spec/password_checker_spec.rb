require 'password_checker'

RSpec.describe PasswordChecker do
  before do
    @target = described_class.new
  end

  after do
    # Do nothing
  end

  context 'Normal passwords' do
    it 'fail if password is less than 7 characters' do
      password = "123456"
      result = @target.check_password(password)
      expect(result).to eq(false)
    end
  end
end
