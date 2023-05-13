require 'optparse'
require 'date'
day = Date.today
year = day.year
month = day.month
opt = OptionParser.new
opt.on('-y VAL') {|v| year = v.to_i }
opt.on('-m VAL') {|v| month = v.to_i }
opt.parse!(ARGV)
puts "\x1B[36;1m#{month}\x1B[37;m月\x1B[36;1m#{year}\x1B[37;m".rjust(38)
puts "日 月 火 水 木 金 土"
end_of_date = Date.new(year, month, -1).day
start_of_date = Date.new(year, month, 1).wday

day_of_week = 0
(0..start_of_date).each do |wday|
  print " ".ljust(2)
end

# day_of_week = 0
# while day_of_week < start_of_date
#   day_of_week += 1
#   if day_of_week == 1
#     print " ".rjust(2)
#   else
#     print " ".rjust(3)
#   end
# end

today = day.day
(1..end_of_date).each do |day|
  case 
  when day == today && day < 10 && (day_of_week)%7 == 0
    print "\x1B[31;1m#{day}\x1B[37;m".rjust(15)
  when day == today && day < 10 
    print "\x1B[31;1m#{day}\x1B[37;m".rjust(16)
  when day == today
    print "\x1B[31;1m#{day}\x1B[37;m".rjust(15)
  when (day_of_week)%7 == 0 && day < 10
    print "\x1B[36;1m#{day}\x1B[37;m".rjust(15)
  when (day_of_week)%7 == 0 
    print "\x1B[36;1m#{day}\x1B[37;m"
  else 
    print " " + "\x1B[36;1m#{day}\x1B[37;m".rjust(15)
  end
  if ((day_of_week+=1)%7 == 0)
    puts
  end
end

# today = day.day
# num = 0
# while num < end_of_date do
#   num += 1
#   case 
#   when num == today && num < 10 && (day_of_week)%7 == 0
#     print "\x1B[31;1m#{num}\x1B[37;m".rjust(15)
#   when num == today && num < 10 
#     print "\x1B[31;1m#{num}\x1B[37;m".rjust(16)
#   when num == today
#     print "\x1B[31;1m#{num}\x1B[37;m".rjust(15)
#   when (day_of_week)%7 == 0 && num < 10
#     print "\x1B[36;1m#{num}\x1B[37;m".rjust(15)
#   when (day_of_week)%7 == 0 
#     print "\x1B[36;1m#{num}\x1B[37;m"
#   else 
#     print " " + "\x1B[36;1m#{num}\x1B[37;m".rjust(15)
#   end
#   if ((day_of_week+=1)%7 == 0)
#     puts
#   end
# end
