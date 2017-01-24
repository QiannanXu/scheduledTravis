require 'SecureRandom'

File.open("hello.txt", 'w') do |file|
  file.write(SecureRandom.uuid)
end
