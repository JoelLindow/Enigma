class Crack
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
      decrypted_attempt
    end
  end
end
