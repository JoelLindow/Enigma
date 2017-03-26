require_relative 'enigma_input.rb'
require 'pry'
require 'date'

class EnigmaSuite
  attr_reader :encryption_key, :key_array, :rotation_key, :date_key

  def initialize
    @encryption_key = generate_encryption_key
    @date_key = generate_date_key
    @key_array = @encryption_key.zip(@date_key)
    @rotation_key = [15, 19, 8, 4]#@key_array.map { |x| x.reduce(:+)}
    @alphabet = ('a'..'z').to_a
    #binding.pry
  end

  def encrypt(string)
    chunked_string = split_to_four_letter_arrays(string)
    encrypted_array = []
    chunked_string.each do |four_letter_chunk|
      four_letter_chunk.each_with_index do |letter, i|
        encrypted_array << rotate(find_letter_index(letter), @rotation_key[i])
      end
    end
    encrypted_array.join
  end

  def decrypt(string)
    chunked_string = split_to_four_letter_arrays(string)
    decrypted_array = []
    chunked_string.each do |four_letter_chunk|
      four_letter_chunk.each_with_index do |letter, i|
        decrypted_array << rotate(find_letter_index(letter), (@rotation_key[i] *-1))
      end
    end
    decrypted_array.join
  end

  def crack(string, generate_date_key)

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
    number_to_array_of_characters.last(4).map(&:to_i)
  end

  def gen_random_five_digit_number
    rand(99999)
  end

  def conv_num_to_five_dig(number)
    "%05d" % number
  end

  def rotate(letter_index, rotation)
    @alphabet.rotate(rotation)[letter_index]
  end

  def find_letter_index(letter)
    @alphabet.index(letter.downcase)
  end

  def split_to_four_letter_arrays(string)
    string.chars.each_slice(4).to_a
  end
end


crack = EnigmaSuite.new

#binding.pry



#Rotation alph.rotate(rotation_key)[index]
