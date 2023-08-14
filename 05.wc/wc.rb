# frozen_string_literal: true

require 'optparse'

def main
  option, file_names = parse_options

  if file_names.empty?
    print_counts_for_stdin(option)
  else
    count_and_print_files(file_names, option)
  end
end

def parse_options
  opt = OptionParser.new
  option = {}
  opt.on('-l') { |l| option[:l] = l }
  opt.on('-w') { |w| option[:w] = w }
  opt.on('-c') { |c| option[:c] = c }
  file_names = opt.parse(ARGV)
  [option, file_names]
end

def print_counts_for_stdin(option)
  file_content = $stdin.read
  line, word, byte = count(file_content)
  print_count(line, word, byte, option, '')
end

def count(file_content)
  line = file_content.lines.count
  word = file_content.split.size
  byte = file_content.size
  [line, word, byte]
end

def print_count(line, word, byte, option, file_name)
  counts = []
  counts.push(line) if option[:l] || option.empty?
  counts.push(word) if option[:w] || option.empty?
  counts.push(byte) if option[:c] || option.empty?
  counts.each do |count|
    print count.to_s.rjust(8)
  end
  puts " #{file_name}"
end

def count_and_print_files(file_names, option)
  lines_total = 0
  split_total = 0
  sizet_total = 0

  file_names.each do |file_name|
    file_content = File.read(file_name)
    line, word, byte = count(file_content)
    print_count(line, word, byte, option, file_name)
    lines_total += line
    split_total += word
    sizet_total += byte
  end

  print_count(lines_total, split_total, sizet_total, option, 'total') if file_names.size >= 2
end

main
