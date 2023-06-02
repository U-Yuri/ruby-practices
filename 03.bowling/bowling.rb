# frozen_string_literal: true

# ボウリングスコアプログラム

score = ARGV[0]
scores = score.split(',')
shots = []
All_PIN = 10
scores.each do |s|
  if s == 'X'
    shots << All_PIN
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
frames.each_with_index do |frame, number_of_times|
  next_score = frames[number_of_times + 1]
  next_next_score = frames[number_of_times + 2]
  point += frame.sum
  if frame[0] == All_PIN && number_of_times < 9
    point += next_score[0]
    point += if next_score[0] == All_PIN
               next_next_score[0]
             else
               next_score[1]
             end

  elsif frame.sum == All_PIN && number_of_times < 9
    point += next_score[0]
  end
end

puts point
