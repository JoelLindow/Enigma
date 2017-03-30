require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enigma.rb'
require 'pry'

class EnigmaTest < MiniTest::Test
  def test_enigmasuite_creates_new_instance
    code = Enigma.new
    assert_instance_of Enigma, code
  end

  def test_encryption_key_generates_four_digit_values
    code = Enigma.new
    assert_equal 4, code.encryption_key.length
  end

  def test_encryption_key_generates_integer_values
    code = Enigma.new
    assert code.encryption_key.all? { |x| x.class == Fixnum }
  end

  def test_date_key_generates_four_digit_values
    code = Enigma.new
    assert_equal 4, code.date_key.length
  end

  def test_date_key_generates_integer_values
    code = Enigma.new
    assert code.date_key.all? { |x| x.class == Fixnum }
  end

  def test_rotation_key_generates_four_digit_values
    code = Enigma.new
    assert_equal 4, code.rotation_key.length
  end

  def test_rotation_key_generates_integer_values
    code = Enigma.new
    assert code.rotation_key.all? { |x| x.class == Fixnum }
  end

  def test_find_letter_index_returns_correct_index
    code = Enigma.new
    assert_equal 63, code.find_letter_index('m')
  end

  def test_find_letter_index_handles_uppercase
    code = Enigma.new
    assert_equal 23, code.find_letter_index('D')
  end

  def test_rotate_returns_correct_letter
    code = Enigma.new
    assert_equal '2', code.rotate(code.find_letter_index('u'), 15)
  end

  def test_split_four_letter_arrays
    code = Enigma.new
    two_chunks = [["b", "r", "e", "a"], ["k", " ", "i", "t"]]
    assert_equal two_chunks, code.split_to_four_letter_arrays('break it')
  end

  def test_encryption_works
    code = Enigma.new([15, 19, 8, 4])
    assert_equal '2umv', code.encrypt('uber')
  end

  def test_decryption_works
    code = Enigma.new([15, 19, 8, 4])
    assert_equal 'uber', code.decrypt('2umv')
  end

  def test_encryption_handles_spaces
    code = Enigma.new([15, 19, 8, 4])
    assert_equal '2umv9,qrs0,', code.encrypt('uber lindow')
  end

  def test_decryptor_handles_spaces
    code = Enigma.new([15, 19, 8, 4])
    assert_equal 'uber lindow', code.decrypt('2umv9,qrs0,')
  end

  def test_crack_can_crack_all_zeroes_encryption_key
    code = Enigma.new
    assert_equal 'uber lindow ..end..', code.crack('n<oEuFsA]I.Oz[oA][9')
  end

  def test_crack_can_longer_string
    code = Enigma.new
    message = "Sometimes you just have to throw the kitchen sink at it too ..end.."
    assert_equal message, code.crack('9T6wYN6wXbB.Zb35XYEzF[-<YTE4MW87bY1wbP24HM--bX2-Pb 4bN=<YT8<gg--IgJ')
  end
end
