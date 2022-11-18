require 'password_checker'

RSpec.describe PasswordChecker do
  before do
    @target = described_class.new
  end

  after do
    # Do nothing
  end
  context 'Normal Passwords' do
    before do
      @target = described_class.new
    end
    context 'length check' do
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

    context 'character check' do
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

    context 'strength' do
      it 'does not meet length req' do
        password = "12345a"
        expect do
          @target.check_password(password)
        end.to output('Does not contain 7 characters').to_stdout
      end

      it 'does not meet letter req' do
        password = "1234567"
        expect do
          @target.check_password(password)
        end.to output('Does not contain one letter').to_stdout
      end

      it 'does not meet number req' do
        password = "abcdefg"
        expect do
          @target.check_password(password)
        end.to output('Does not contain one number').to_stdout
      end

      it 'does not meet letter and number req' do
        password = "abcdefg"
        expect do
          @target.check_password(password)
        end.to output('Does not contain one letter\nDoes not contain one number').to_stdout
      end

      it 'does not meet letter and length req' do
        password = "123456"
        expect do
          @target.check_password(password)
        end.to output('Does not contain 7 characters\nDoes not contain one letter').to_stdout
      end

      it 'does not meet number and length req' do
        password = "abcdef"
        expect do
          @target.check_password(password)
        end.to output('Does not contain 7 characters\nDoes not contain one number').to_stdout
      end

      it 'does not meet any requirement' do
        password = ""
        expect do
          @target.check_password(password)
        end.to output('Does not contain 7 characters\nDoes not contain one letter\nDoes not contain one number').to_stdout
      end
    end
  end

  context 'Admin passwords' do
    before do
      @target = described_class.new(admin: true)
    end

    context 'length check' do
      it 'false if password is less than 10 characters' do
        password = "1234567)a"
        result = @target.check_password(password)
        expect(result).to eq(false)
      end

      it 'true if password is == 10 characters' do
        password = "12345678)a"
        result = @target.check_password(password)
        expect(result).to eq(true)
      end

      it 'true if password is > 10 characters' do
        password = "123456789)a"
        result = @target.check_password(password)
        expect(result).to eq(true)
      end
    end

    context 'character check' do
      it 'false if password does not contain letter' do
        password = "123456789)"
        result = @target.check_password(password)
        expect(result).to eq(false)
      end

      it 'false if password does not contain number' do
        password = "abcdefghi)"
        result = @target.check_password(password)
        expect(result).to eq(false)
      end

      it 'false if password does not contain special number' do
        password = "abcdefghi1"
        result = @target.check_password(password)
        expect(result).to eq(false)
      end

      it 'true if password contains letter, number, special character' do
        special = %w{!@#$%^&*()_+{}\[\]:;'"\/\\?><.,}.sample
        password = "12345678a!#{special}"
        result = @target.check_password(password)
        expect(result).to eq(true)
      end
    end
  end
end
