require_relative 'enigma_input.rb'
require 'pry'
require 'date'

class EnigmaSuite
  attr_reader :encryption_key, :key_array, :rotation_key, :date_key


  def initialize(rotation_key = nil)
    @encryption_key = generate_encryption_key
    @date_key = generate_date_key
    @rotation_key = rotation_key || combine(zip_two_arrays(@encryption_key, @date_key))
    @alphabet = character_map
    #binding.pry
  end

  def encrypt(message)
    chunked_string = split_to_four_letter_arrays(message)
    encrypted_array = chunked_string.map do |four_letter_chunk|
      four_letter_chunk.map.with_index(0) do |letter, i|
          rotate(find_letter_index(letter), @rotation_key[i])
      end
    end
    encrypted_array.join
    # binding.pry
  end

  def decrypt(message, rotation_key = @rotation_key)
    chunked_string = split_to_four_letter_arrays(message)
    decrypted_array = chunked_string.map do |four_letter_chunk|
      four_letter_chunk.map.with_index(0) do |letter, i|
          rotate(find_letter_index(letter), (rotation_key[i] *-1))
      end
    end
    decrypted_array.join
  end

  def crack(message, day = 0)
    encryption_key = '00000'
    date_key = generate_date_key(day)
    loop do
      encrypted_array = breaks_five_digit_string_to_array_of_four(encryption_key)
      rotation_key = combine(zip_two_arrays(encrypted_array, date_key))

      decrypted_attempt = decrypt(message, rotation_key)
      if decrypted_attempt.slice(-7, 7) == "..end.."
        return decrypted_attempt
        break
      elsif encryption_key.to_i > 100000
        break
      end
      encryption_key_new = encryption_key.to_i + 1
      encryption_key = conv_num_to_five_dig(encryption_key_new)
      #binding.pry
      decrypted_attempt
    end
  end

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
    #binding.pry
    @alphabet.rotate(rotation)[letter_index]
  end

  def find_letter_index(letter)
    @alphabet.index(letter)
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

  def character_map
    encryption_alphabet = (','..'z').to_a
    encryption_alphabet.delete_at(48)
    encryption_alphabet.delete("/")
    encryption_alphabet.push('"')
    encryption_alphabet.push(' ')
    encryption_alphabet
  end

end



banana = EnigmaSuite.new#([0, 3, 8, 4])
#crack.crack('jumv eqrshe', 1005)
# ""
puts banana.encrypt('whatever I want I want you son of a bitch ..end..')
#puts banana.encrypt('uber lindow')
#puts banana.crack('[@9 cJ=xJMK6f^9xJ^S')
#puts banana.decrypt('wli-ezm" M 1ar, I iuwe2, -mul 4kixkq?0 8.ivm.3')

#binding.pry
""
