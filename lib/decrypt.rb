require './lib/enigma'

enigma = Enigma.new
input_filename = ARGV[0]
output_filename = ARGV[1]
key = ARGV[2]
date = ARGV[3]
message = enigma.parse_message(input_filename)
encryption = enigma.encrypt(message, key, date)

puts "Created #{output_filename} with the key #{key} and date #{date}."
