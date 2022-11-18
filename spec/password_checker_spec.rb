require 'password_checker'

RSpec.describe PasswordChecker do
  before do
    @target = described_class.new
  end

  context 'normal users' do
    before do
      @target = described_class.new
    end
    
    context 'length' do
      it 'false if less than 7 characters' do
        @target.password = "12345a"
        result = @target.check_password?
        expect(result).to eq(false)
      end

      it 'true if equal to 7 characters' do
        @target.password = "123456a"
        result = @target.check_password?
        expect(result).to eq(true)
      end

      it 'true if more than 7 characters' do
        @target.password = "1234567a"
        result = @target.check_password?
        expect(result).to eq(true)
      end
    end

    context 'character' do
      it 'false if no letter' do
        @target.password = "1234567"
        result = @target.check_password?
        expect(result).to eq(false)
      end

      it 'false if no number' do
        @target.password = "abcdefghi"
        result = @target.check_password?
        expect(result).to eq(false)
      end

      it 'true if letter and number' do
        @target.password = "1234567abc"
        result = @target.check_password?
        expect(result).to eq(true)
      end
    end

    context 'strength' do
      it 'length' do
        @target.password = "12345a"
        expected_output = "Does not contain 7 characters\n"
        expect do
          @target.check_password?
        end.to output(expected_output).to_stdout
      end

      it 'letter' do
        @target.password = "1234567"
        expected_output = "Does not contain one letter\n"
        expect do
          @target.check_password?
        end.to output(expected_output).to_stdout
      end

      it 'number' do
        @target.password = "abcdefg"
        expected_output = "Does not contain one number\n"
        expect do
          @target.check_password?
        end.to output(expected_output).to_stdout
      end

      it 'letter and number' do
        @target.password = "()()()()()()()"
        expected_output = ["Does not contain one letter\n",
                           "Does not contain one number\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end

      it 'length and letter' do
        @target.password = "123456"
        expected_output = ["Does not contain 7 characters\n",
                           "Does not contain one letter\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end

      it 'length and number' do
        @target.password = "abcdef"
        expected_output = ["Does not contain 7 characters\n",
                           "Does not contain one number\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end

      it 'length, letter, and number' do
        @target.password = ""
        expected_output = ["Does not contain 7 characters\n",
                           "Does not contain one letter\n",
                           "Does not contain one number\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end
    end
  end

  context 'admin users' do
    before do
      @target = described_class.new admin: true
    end

    context 'length' do
      it 'false if less than 10 characters' do
        @target.password = "1234567)a"
        result = @target.check_password?
        expect(result).to eq(false)
      end

      it 'true if equal to 10 characters' do
        @target.password = "12345678)a"
        result = @target.check_password?
        expect(result).to eq(true)
      end

      it 'true if more than 10 characters' do
        @target.password = "123456789)a"
        result = @target.check_password?
        expect(result).to eq(true)
      end
    end

    context 'character check' do
      it 'false if no letter' do
        @target.password = "123456789)"
        result = @target.check_password?
        expect(result).to eq(false)
      end

      it 'false if no number' do
        @target.password = "abcdefghi)"
        result = @target.check_password?
        expect(result).to eq(false)
      end

      it 'false if no special number' do
        @target.password = "abcdefghi1"
        result = @target.check_password?
        expect(result).to eq(false)
      end

      it 'true if letter, number, and special character' do
        special = %w{!@#$%^&*()_+{}\[\]:;'"\/\\?><.,}.sample
        @target.password = "12345678a!#{special}"
        result = @target.check_password?
        expect(result).to eq(true)
      end
    end

    context 'strength' do
      it 'length' do
        @target.password = "12345abc)"
        expected_output = "Does not contain 10 characters\n"
        expect do
          @target.check_password?
        end.to output(expected_output).to_stdout
      end

      it 'letter' do
        @target.password = "123456789)"
        expected_output = "Does not contain one letter\n"
        expect do
          @target.check_password?
        end.to output(expected_output).to_stdout
      end

      it 'number' do
        @target.password = "abcdefghi)"
        expected_output = "Does not contain one number\n"
        expect do
          @target.check_password?
        end.to output(expected_output).to_stdout
      end

      it 'special' do
        @target.password = "1abcdefghi"
        expected_output = "Does not contain one special character\n"
        expect do
          @target.check_password?
        end.to output(expected_output).to_stdout
      end

      it 'letter and number' do
        @target.password = "()()()()()()()()"
        expected_output = ["Does not contain one letter\n",
                           "Does not contain one number\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end

      it 'letter and special' do
        @target.password = "1234567891"
        expected_output = ["Does not contain one letter\n",
                           "Does not contain one special character\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end

      it 'number and special' do
        @target.password = "abcdefghij"
        expected_output = ["Does not contain one number\n",
                           "Does not contain one special character\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end

      it 'length and letter' do
        @target.password = "12345678)"
        expected_output = ["Does not contain 10 characters\n",
                           "Does not contain one letter\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end

      it 'length and number' do
        @target.password = "abcdefgh)"
        expected_output = ["Does not contain 10 characters\n",
                           "Does not contain one number\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end

      it 'length and special' do
        @target.password = "1abcdefg"
        expected_output = ["Does not contain 10 characters\n",
                           "Does not contain one special character\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end

      it 'length, letter, and number' do
        @target.password = ")"
        expected_output = ["Does not contain 10 characters\n",
                           "Does not contain one letter\n",
                           "Does not contain one number\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
        end

      it 'length, letter, abd special' do
        @target.password = "1"
        expected_output = ["Does not contain 10 characters\n",
                           "Does not contain one letter\n",
                           "Does not contain one special character\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end

      it 'length, number, and special' do
        @target.password = "a"
        expected_output = ["Does not contain 10 characters\n",
                           "Does not contain one number\n",
                           "Does not contain one special character\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end

      it 'letter, number, and special' do
        @target.password = "                   "
        expected_output = ["Does not contain one letter\n",
                           "Does not contain one number\n",
                           "Does not contain one special character\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end

      it 'length, letter, number, and special' do
        @target.password = ""
        expected_output = ["Does not contain 10 characters\n",
                           "Does not contain one letter\n",
                           "Does not contain one number\n",
                           "Does not contain one special character\n"]
        expect do
          @target.check_password?
        end.to output(expected_output.join).to_stdout
      end
    end
  end
end
