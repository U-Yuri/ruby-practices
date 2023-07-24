require 'optparse'

opt = OptionParser.new
option = {}
opt.on('-l') { |l| option[:l] = l }
opt.on('-w') { |w| option[:w] = w }
opt.on('-c') { |c| option[:c] = c }
opt.parse(ARGV)

if option[:l] || option[:w] || option[:c]
  option_file = File.read("#{ARGV[1]}")
else
  file = File.read("#{ARGV[0]}")
end

def normal(file)
  print file.lines.count.to_s.rjust(7)
  print file.split.size.to_s.rjust(7)
  print file.size.to_s.rjust(7)
  print " #{ARGV[0]}\n"
end

def l(option_file)
  print option_file.lines.count.to_s.rjust(7)
  print " #{ARGV[1]}\n"
end

def w(option_file)
  print option_file.split.size.to_s.rjust(7)
  print " #{ARGV[1]}\n"
end

def c(option_file) 
  print option_file.size.to_s.rjust(7)
  print " #{ARGV[1]}\n"
end

if option[:l]
  l(option_file)
elsif option[:w]
  w(option_file)
elsif option[:c]
  c(option_file)
else
  normal(file)
end
