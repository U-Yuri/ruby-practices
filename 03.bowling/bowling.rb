# frozen_string_literal: true

# ボウリングスコアプログラム

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

point = 0
index = 0
frames.each do |frame|
  next_array_1 = frames[index + 1]
  next_array_2 = frames[index + 2]
  point += frame.sum
  if frame[0] == 10 && index < 9
    if next_array_1[0] == 10 
      point += next_array_1[0] + next_array_2[0]
    else
      point += next_array_1[0] + next_array_1[1]
    end
  elsif frame.sum == 10 && index < 9
    point += next_array_1[0]
  end

  index += 1
end
puts point
