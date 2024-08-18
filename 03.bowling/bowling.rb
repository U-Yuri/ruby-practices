# frozen_string_literal: true

# ボウリングスコアプログラム

score = ARGV[0]
scores = score.split(',')
shots = []
ALL_PIN = 10
scores.each do |s|
  if s == 'X'
    shots << ALL_PIN
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
frames.each_with_index do |frame, index|
  next_frame = frames[index + 1]
  next_next_frame = frames[index + 2]
  point += frame.sum
  if frame[0] == ALL_PIN && index < 9
    point += next_frame[0]
    point += if next_frame[0] == ALL_PIN
               next_next_frame[0]
             else
               next_frame[1]
             end

  elsif frame.sum == ALL_PIN && index < 9
    point += next_frame[0]
  end
end

puts point
