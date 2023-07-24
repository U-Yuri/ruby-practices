#ベース
require 'optparse'

opt = OptionParser.new
option = {}
opt.on('-l') { |a| option[:l] = l }
opt.on('-w') { |r| option[:w] = w }
opt.on('-c') { |l| option[:c] = c }
opt.parse(ARGV)

file = File.read("#{ARGV[0]}")

print file.lines.count
print file.split.size
print file.size
print "#{ARGV[0]}\n"
