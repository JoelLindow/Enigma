# ADD ARGV STUFF!
require './lib/enigma.rb'
require 'date'



message_to_decrypt = File.read(ARGV[0]).chomp
date_key = ARGV[2].chomp

cracker = Enigma.new



decrypted_message = cracker.crack(message_to_decrypt)



File.open(ARGV[1], 'w') do |f|
  f.puts decrypted_message
end
