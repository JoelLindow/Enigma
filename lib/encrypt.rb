
class Encrypt

  def initialize(message)
    @message = message
    encrypt(@message)
  end

  def encrypt(message)
    chunked_string = split_to_four_letter_arrays(message)
    encrypted_array = chunked_string.map do |four_letter_chunk|
      four_letter_chunk.map.with_index(0) do |letter, i|
        rotate(find_letter_index(letter), @rotation_key[i])
      end
    end
    encrypted_array.join
  end
end
