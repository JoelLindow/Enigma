require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enigma_build_suite.rb'
require 'pry'

class EnigmaSuiteTest < MiniTest::Test

  def test_enigmasuite_creates_new_instance
    code = EnigmaSuite.new
    assert_instance_of EnigmaSuite, code
  end


end
