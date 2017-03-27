require_relative 'enigma_input.rb'
require 'pry'
require 'date'

class EnigmaSuite
  attr_reader :encryption_key, :key_array, :rotation_key, :date_key

  def initialize
    @encryption_key = generate_encryption_key
    @date_key = generate_date_key
    @rotation_key = [15, 19, 8, 4]#combine(zip_two_arrays(@encryption_key, @date_key))
    @alphabet = ('a'..'z').to_a
    #binding.pry
  end

  def encrypt(string)
    chunked_string = split_to_four_letter_arrays(string)
    encrypted_array = []
    chunked_string.each do |four_letter_chunk|
      four_letter_chunk.each_with_index do |letter, i|
        if letter == " "
          encrypted_array << letter
        else
          encrypted_array << rotate(find_letter_index(letter), @rotation_key[i])
        end
      end
    end
    encrypted_array.join
  end

  def decrypt(string, rotation_key = @rotation_key)
    chunked_string = split_to_four_letter_arrays(string)
    decrypted_array = []
    chunked_string.each do |four_letter_chunk|
      four_letter_chunk.each_with_index do |letter, i|
        if letter == " "
          decrypted_array << letter
        else
          decrypted_array << rotate(find_letter_index(letter), (rotation_key[i] *-1))
        end
      end
    end
    decrypted_array.join
  end

  # def crack(string, day = 0)
  #   encryption_key = '00000'
  #   encrypted_array = breaks_five_digit_string_to_array_of_four(encryption_key)
  #   date_key = generate_date_key(day)
  #   rotation_key = combine(zip_two_arrays(encrypted_array, date_key))
  #   loop do
  #
  #     break if string.slice(-7, 7) == "..end.."
  #   end
  #
  #   #binding.pry
  #
  # end

  def generate_encryption_key
    random_encryption = conv_num_to_five_dig(gen_random_five_digit_number)
    breaks_five_digit_string_to_array_of_four(random_encryption)
  end

  def breaks_five_digit_string_to_array_of_four(number)
    encryption_key_array = []
    4.times { |i| encryption_key_array << number.slice(i,2).to_i }
    encryption_key_array
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

  def zip_two_arrays(array1, array2)
    array1.zip(array2)
  end

  def combine(nested_arrays)
    nested_arrays.map { |x| x.reduce(:+)}
  end
end


crack = EnigmaSuite.new
#crack.crack('jumv eqrshe', 1005)
#binding.pry



#Rotation alph.rotate(rotation_key)[index]
