#require_relative '.rb'
require 'pry'
require 'date'

class EnigmaSuite
 def initialize
   @encryption_key = generate_encryption_key
   @date_key = generate_date_key
   puts @encryption_key
   puts @date_key
 end

 def generate_encryption_key
   random_encryption = rand(99999)
   "%05d" % random_encryption
 end

 def generate_date_key(days = 0)
   (Date.today - days).strftime("%d%m%y")
 end

end


crack = EnigmaSuite.new
