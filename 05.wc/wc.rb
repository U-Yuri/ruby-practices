# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
option = {}
opt.on('-l') { |l| option[:l] = l }
opt.on('-w') { |w| option[:w] = w }
opt.on('-c') { |c| option[:c] = c }
argv = opt.parse(ARGV)

if argv[0].nil?
  file = []
  loop do
    file_name = $stdin.gets
    break if file_name.nil?

    file.push(file_name.to_s)
  end
  file = file.join
else
  file = File.read(argv[0].to_s)
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
