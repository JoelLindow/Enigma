require './lib/enigma.rb'
require 'date'



message_to_decrypt = File.read(ARGV[0]).chomp
command_line_rotation_key = ARGV[2].chomp
command_line_date_key = ARGV[3].chomp
decryptor = Enigma.new

encryption_key = decryptor.five_dig_rand_enc_to_array(command_line_rotation_key)
date_key = decryptor.generate_date_key(command_line_date_key)
rotation_key = decryptor.combine(decryptor.zip_two_arrays(encryption_key, date_key))
decrypted_message = decryptor.decrypt(message_to_decrypt, rotation_key)



File.open(ARGV[1], 'w') do |f|
  f.puts decrypted_message
end
#
# puts "Created #{ARGV[1]} with the key #{decryptor.rotation_key.join} and date #{Date.today.strftime("%d%m%y")}"
