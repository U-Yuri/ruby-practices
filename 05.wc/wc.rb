#ベース
require 'optparse'

file = File.read("#{ARGV[0]}")

print file.lines.count
print file.split.size
print file.size
print "#{ARGV[0]}\n"
