# ADD ARGV STUFF!
require './lib/enigma.rb'
require 'date'
require 'pry'


message_to_decrypt = File.read(ARGV[0]).chomp

date_key = ARGV[2].chomp

#date_key = date_key_command_line.chars.map(&:to_i)
#binding.pry
cracker = Enigma.new



decrypted_message = cracker.crack(message_to_decrypt, date_key)



File.open(ARGV[1], 'w') do |f|
  f.puts decrypted_message
end
