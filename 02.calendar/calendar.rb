require 'optparse'
require 'date'
day = Date.today
year = day.year
month = day.month
opt = OptionParser.new
opt.on('-y VAL') {|v| year = v.to_i }
opt.on('-m VAL') {|v| month = v.to_i }
opt.parse!(ARGV)
puts "     \x1B[36;1m#{month}\x1B[37;m月\x1B[36;1m#{year}\x1B[37;m"
puts "日 月 火 水 木 金 土"
end_of_date = Date.new(year, month, -1).day
start_of_date = Date.new(year, month, 1).wday

(0..start_of_date-1).each do |wday|
  print "   "
end

day_of_week = start_of_date
today = day.day

(1..end_of_date).each do |day|
  day_colomn = "#{day}".rjust(2)
  case 
  when day == today
    print "\x1B[31;1m" + day_colomn + "\x1B[37;m" + " "
  else 
    print "\x1B[36;1m" + day_colomn + "\x1B[37;m" + " "
  end
  
  case
  when day_of_week%7 == 6
    print "\n"
  end
  day_of_week = day_of_week + 1
 end
