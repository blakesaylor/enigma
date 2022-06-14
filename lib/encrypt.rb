require './lib/enigma'

enigma = Enigma.new
input_filename = ARGV[0]
output_filename = ARGV[1]
key = enigma.generate_random_key_string
date = enigma.generate_todays_date_string
message = enigma.parse_message(input_filename)
encrypted_message = enigma.encrypt(message, key, date)
enigma.write_message(encrypted_message[:encryption], output_filename)

puts "Created #{output_filename} with the key #{key} and date #{date}."
