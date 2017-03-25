require_relative 'enigma_input.rb'
require 'pry'
require 'date'

class EnigmaSuite
  attr_reader :encryption_key, :key_array, :rotation_key, :date_key

  def initialize
    @encryption_key = generate_encryption_key
    @date_key = generate_date_key
    @key_array = @encryption_key.zip(@date_key)
    @rotation_key = @key_array.map { |x| x.reduce(:+)}
    @alphabet = ('a'..'z').to_a
    #binding.pry
  end

  def encryptor

  end

  def generate_encryption_key
    random_encryption = conv_num_to_five_dig(gen_random_five_digit_number)
    encryption_key_array = []
    4.times { |i| encryption_key_array << random_encryption.slice(i,2).to_i }
    encryption_key_array
    #binding.pry
  end

  def generate_date_key(days = 0)
    date = (Date.today - days).strftime("%d%m%y")
    date_squared = date.to_i**2
    isolate_last_four_digits(date_squared)
  end

  def isolate_last_four_digits(number)
    number_to_array_of_characters = number.to_s.chars
    number_to_array_of_characters.slice(-4, 4).map(&:to_i)
  end

  def gen_random_five_digit_number
    rand(99999)
  end

  def conv_num_to_five_dig(number)
    "%05d" % number
  end
end


crack = EnigmaSuite.new

#binding.pry



#Rotation alph.rotate(rotation_key)[index]
