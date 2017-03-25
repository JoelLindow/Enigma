#require_relative '.rb'
require 'pry'
require 'date'

class EnigmaSuite
  def initialize
    @encryption_key = generate_encryption_key
    @date_key = generate_date_key
    @key_array = @encryption_key.zip(@date_key)
    puts "Encryption Key: #{@encryption_key}"
    puts "Date Key: #{@date_key}"
    puts "Key Array: #{@key_array}"
  end

  def generate_encryption_key
    random_encryption = rand(99999)
    random_encryption_leading_zeroes = "%05d" % random_encryption
    random_encryption_leading_zeroes
    encryption_key_array = []
    4.times do |i|
      encryption_key_array << random_encryption_leading_zeroes.slice(i,2).to_i
    end
    encryption_key_array
  end

  def break_down_encryption_key

  end

  def generate_date_key(days = 0)
    date = (Date.today - days).strftime("%d%m%y")
    date_squared = date.to_i**2
    last_four_digits = date_squared.to_s.chars.slice(-4, 4)
    last_four_digits.map(&:to_i)
  end
end


crack = EnigmaSuite.new
