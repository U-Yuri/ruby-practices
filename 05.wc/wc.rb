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
  count_content = count(file_content)
  print_count(count_content, option, '')
end

def count(file_content)
  {
    line: file_content.lines.count,
    word: file_content.split.count,
    byte: file_content.size
  }
end

def print_count(count_content, option, file_name)
  line_count = count_content[:line]
  word_count = count_content[:word]
  byte = count_content[:byte]

  counts = []
  counts.push(line_count) if option[:l] || option.empty?
  counts.push(word_count) if option[:w] || option.empty?
  counts.push(byte) if option[:c] || option.empty?
  counts.each do |count|
    print count.to_s.rjust(8)
  end
  puts " #{file_name}"
end

def count_and_print_files(file_names, option)
  lines_total = 0
  word_total = 0
  byte_total = 0

  file_names.each do |file_name|
    file_content = File.read(file_name)
    count_content = count(file_content)
    print_count(count_content, option, file_name)
    lines_total += count_content[:line]
    word_total += count_content[:word]
    byte_total += count_content[:byte]
  end
  total_counts = {
    line: lines_total,
    word: word_total,
    byte: byte_total
  }

  print_count(total_counts, option, 'total') if file_names.size >= 2
end

main
