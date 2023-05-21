# ボウリングスコアプログラム
require 'debug'

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end
p frames

point = 0
index = 0
# debugger
frames.each do |frame|
  # debugger
  next_array = frames[index + 1]
  
  case
  when frame[0] == 10 && index < 9
    # debugger
      point += frame[0] + next_array[0] + next_array[1]
  when frame.sum == 10 && index < 9
      point += frame.sum + next_array[0] if index < 9
  else 
    point += frame.sum
  end
  print "index=#{index} frame=#{frame} point=#{point}\n"
  index += 1
end
puts point