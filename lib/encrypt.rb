require './lib/enigma.rb'
require 'date'

message_to_encrypt = File.read(ARGV[0]).chomp
encryptor = Enigma.new
encrypted_message = encryptor.encrypt(message_to_encrypt)
key = encryptor.encryption_key

File.open(ARGV[1], 'w') do |f|
  f.puts encrypted_message
end


puts "Created #{ARGV[1]} with the key #{encryptor.random_encryption} and date #{Date.today.strftime("%d%m%y")}"
