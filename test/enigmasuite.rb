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

end
