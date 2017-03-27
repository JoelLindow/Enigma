require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enigma_build_suite.rb'
require 'pry'

class EnigmaSuiteTest < MiniTest::Test
  def test_enigmasuite_creates_new_instance
    code = EnigmaSuite.new
    assert_instance_of EnigmaSuite, code
  end

  def test_encryption_key_generates_four_digit_values
    code = EnigmaSuite.new
    assert_equal 4, code.encryption_key.length
  end

  def test_encryption_key_generates_integer_values
    code = EnigmaSuite.new
    assert code.encryption_key.all? { |x| x.class == Fixnum }
  end

  def test_date_key_generates_four_digit_values
    code = EnigmaSuite.new
    assert_equal 4, code.date_key.length
  end

  def test_date_key_generates_integer_values
    code = EnigmaSuite.new
    assert code.date_key.all? { |x| x.class == Fixnum }
  end

  def test_rotation_key_generates_four_digit_values
    code = EnigmaSuite.new
    assert_equal 4, code.rotation_key.length
  end

  def test_rotation_key_generates_integer_values
    code = EnigmaSuite.new
    assert code.rotation_key.all? { |x| x.class == Fixnum }
  end

  def test_find_letter_index_returns_correct_index
    code = EnigmaSuite.new
    assert_equal 12, code.find_letter_index('m')
  end

  def test_find_letter_index_handles_uppercase
    code = EnigmaSuite.new
    assert_equal 3, code.find_letter_index('D')
  end

  def test_rotate_returns_correct_letter
    code = EnigmaSuite.new
    assert_equal 'j', code.rotate(code.find_letter_index('u'), 15)
  end

  def test_split_four_letter_arrays
    code = EnigmaSuite.new
    two_chunks = [["b", "r", "e", "a"], ["k", " ", "i", "t"]]
    assert_equal two_chunks, code.split_to_four_letter_arrays('break it')
  end

  def test_encryption_works
    #skip
    code = EnigmaSuite.new
    @rotation_key = [15, 19, 8, 4]
    assert_equal 'jumv', code.encrypt('uber')
  end

  def test_encryption_works
    #skip
    code = EnigmaSuite.new
    @rotation_key = [15, 19, 8, 4]
    assert_equal 'uber', code.decrypt('jumv')
  end

  def test_encryption_handles_spaces
    code = EnigmaSuite.new
    @rotation_key = [15, 19, 8, 4]
    assert_equal 'jumv eqrshe', code.encrypt('uber lindow')
  end

  def test_decryptor_handles_spaces
    code = EnigmaSuite.new
    @rotation_key = [15, 19, 8, 4]
    assert_equal 'uber lindow', code.decrypt('jumv eqrshe')
  end

  def test_crack_can_crack_all_zeroes_encryption_key
    skip
    code = EnigmaSuite.new
    assert_equal 'uber lindow', code.crack('jumv eqrshe')
  end
end
