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
    assert_equal '4', code.rotate(code.find_letter_index('u'), 15)
  end

  def test_split_four_letter_arrays
    code = Enigma.new
    two_chunks = [["b", "r", "e", "a"], ["k", " ", "i", "t"]]
    assert_equal two_chunks, code.split_to_four_letter_arrays('break it')
  end

  def test_encryption_works
    code = Enigma.new([15, 19, 8, 4])
    assert_equal '4umv', code.encrypt('uber')
  end

  def test_decryption_works
    skip
    code = Enigma.new([15, 19, 8, 4])
    assert_equal 'uber', code.decrypt('4umv')
  end

  def test_encryption_handles_spaces
    skip
    code = EnigmaSuite.new([15, 19, 8, 4])
    assert_equal '4umv;.qrs2.', code.encrypt('uber lindow')
  end

  def test_decryptor_handles_spaces
    skip
    code = EnigmaSuite.new([15, 19, 8, 4])
    assert_equal 'uber lindow', code.decrypt('4umv;.qrs2.')
  end

  def test_crack_can_crack_all_zeroes_encryption_key
    skip
    code = EnigmaSuite.new
    assert_equal 'uber lindow ..end..', code.crack('[@9 cJ=xJMK6f^9xJ^S')
  end

  def test_crack_can_crack_higher_rotation_key
    skip
    code = EnigmaSuite.new
    message = 'whatever I want I want you son of a bitch ..end..'
    assert_equal message, code.crack('iST>VbX<n5pARYhF;hk"``pCaap=aYp9WhTFSTh,YhsIVYWIq')
  end
end
