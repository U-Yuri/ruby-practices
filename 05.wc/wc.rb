require 'optparse'

opt = OptionParser.new
option = {}
opt.on('-l') { |l| option[:l] = l }
opt.on('-w') { |w| option[:w] = w }
opt.on('-c') { |c| option[:c] = c }
argv = opt.parse(ARGV)

def l(file)
  print file.lines.count.to_s.rjust(7)
end

def w(file)
  print file.split.size.to_s.rjust(7)
end

def c(file) 
  print file.size.to_s.rjust(7)
end

file = File.read("#{argv[0]}")

if option[:l]
  l(file)
elsif option[:w]
  w(file)
elsif option[:c]
  c(file)
else
  l(file)
  w(file)
  c(file)
end

print " #{argv[0]}\n"
