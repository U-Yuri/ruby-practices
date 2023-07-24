#ベース
require 'optparse'

print File.read("#{ARGV[0]}").count("\n")
print "#{ARGV[0]}\n"
