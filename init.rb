Dir['tmp/*'].each do |path|
  reversed_name = File.basename(path, '.txt').reverse
  File.rename(path, File.dirname(path) + '/' + reversed_name + '.txt')
end
