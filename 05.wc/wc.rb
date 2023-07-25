# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
option = {}
opt.on('-l') { |l| option[:l] = l }
opt.on('-w') { |w| option[:w] = w }
opt.on('-c') { |c| option[:c] = c }
argv = opt.parse(ARGV)

if argv[0] == nil
  file = []
  while true
    file_name = $stdin.gets
    if file_name == nil
      break
    end
    file.push("#{file_name}")
  end
  file = file.join
else
  file = File.read("#{argv[0]}")
end

option_l = file.lines.count.to_s.rjust(8)
option_w = file.split.size.to_s.rjust(8)
option_c = file.size.to_s.rjust(8)

print option_l if option[:l]
print option_w if option[:w]
print option_c if option[:c]

if option == {}
  print option_l
  print option_w
  print option_c
end

print " #{argv[0]}\n"
