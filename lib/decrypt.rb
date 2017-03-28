
class Decrypt
  def decrypt(message, rotation_key = @rotation_key)
    chunked_string = split_to_four_letter_arrays(message)
    decrypted_array = chunked_string.map do |four_letter_chunk|
      four_letter_chunk.map.with_index(0) do |letter, i|
        rotate(find_letter_index(letter), (rotation_key[i] *-1))
      end
    end
    decrypted_array.join
  end
end
