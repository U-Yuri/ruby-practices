require 'optparse'

opt = OptionParser.new
option = {}
opt.on('-l') { |l| option[:l] = l }
opt.on('-w') { |w| option[:w] = w }
opt.on('-c') { |c| option[:c] = c }
argv = opt.parse(ARGV)

file = File.read("#{argv[0]}")
option_l = file.lines.count.to_s.rjust(7)
option_w = file.split.size.to_s.rjust(7)
option_c = file.size.to_s.rjust(7)

print option_l if option[:l]
print option_w if option[:w]
print option_c if option[:c]

if option == {}
  print option_l
  print option_w
  print option_c
end

print " #{argv[0]}\n"
