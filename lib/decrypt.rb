require './lib/enigma'

if ARGV.length < 4
  puts 'Invalid entry. Please try again in the format of:'
  puts 'ruby ./lib/decrypt.rb inputfile.txt outputfile.txt key date'
  puts 'e.g. ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 02715 040895'
else
  enigma = Enigma.new
  input_filename = ARGV[0]
  output_filename = ARGV[1]
  key = ARGV[2]
  date = ARGV[3]
  message = enigma.parse_message(input_filename)
  decrypted_message = enigma.decrypt(message, key, date)
  enigma.write_message(decrypted_message[:decryption], output_filename)

  puts "Created #{output_filename} with the key #{key} and date #{date}."
end
