require 'optparse'
require 'date'

today = Date.today
year = today.year
month = today.month

opt = OptionParser.new
opt.on('-y VAL') {|v| year = v.to_i }
opt.on('-m VAL') {|v| month = v.to_i }
opt.parse!(ARGV)

puts "     \x1B[36;1m#{month}\x1B[37;m月\x1B[36;1m#{year}\x1B[37;m"
puts "日 月 火 水 木 金 土"

end_of_date = Date.new(year, month, -1)
start_of_date = Date.new(year, month, 1)

(0..start_of_date.wday-1).each do |wday|
  print "   "
end

day_of_week = start_of_date.wday

(start_of_date..end_of_date).each do |day|
  day_colomn = day.day.to_s.rjust(2)
  print (day == today) ? "\x1B[31;1m" : "\x1B[36;1m"
  print day_colomn + "\x1B[37;m" + " "
  print "\n" if day.saturday?
   
  day_of_week = day_of_week + 1
 end
