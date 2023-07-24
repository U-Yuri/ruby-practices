require 'optparse'

opt = OptionParser.new
option = {}
opt.on('-l') { |l| option[:l] = l }
opt.on('-w') { |w| option[:w] = w }
opt.on('-c') { |c| option[:c] = c }
argv = opt.parse(ARGV)

def normal(file)
  print file.lines.count.to_s.rjust(7)
  print file.split.size.to_s.rjust(7)
  print file.size.to_s.rjust(7)
end

def l(option_file)
  print option_file.lines.count.to_s.rjust(7)
end

def w(option_file)
  print option_file.split.size.to_s.rjust(7)
end

def c(option_file) 
  print option_file.size.to_s.rjust(7)
end

if option[:l] || option[:w] || option[:c]
  option_file = File.read("#{argv[0]}")
else
  file = File.read("#{argv[0]}")
end

if option[:l]
  l(option_file)
  print " #{argv[0]}\n"
elsif option[:w]
  w(option_file)
  print " #{argv[0]}\n"
elsif option[:c]
  c(option_file)
  print " #{argv[0]}\n"
else
  normal(file)
  print " #{argv[0]}\n"
end
