# frozen_string_literal: true

require 'optparse'
require 'debug'

def main
  # debugger
  option, file_names = parse_options

  if file_names[0].nil?
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
  option_l, option_w, option_c = count(file_content)
  print_count(option_l, option_w, option_c, option)
  puts
end

def count(file_content)
  option_l = file_content.lines.count
  option_w = file_content.split.size
  option_c = file_content.size
  [option_l, option_w, option_c]
end

def print_count(option_l, option_w, option_c, option)
  print option_l.to_s.rjust(8) if option[:l] || option.empty?
  print option_w.to_s.rjust(8) if option[:w] || option.empty?
  print option_c.to_s.rjust(8) if option[:c] || option.empty?
end

def print_count2(option_l, option_w, option_c, option, file_name)
  print_count(option_l, option_w, option_c, option)
  puts " #{file_name}"
end

def count_and_print_files(file_names, option)
  lines_count_total = 0
  split_count_total = 0
  size_count_total = 0

  file_names.each do |file_name|
    file_content = File.read(file_name)
    option_l, option_w, option_c = count(file_content)
    print_count2(option_l, option_w, option_c, option, file_name)
    lines_count_total += option_l
    split_count_total += option_w
    size_count_total += option_c
  end

  if file_names.size >= 2
    print_count2(lines_count_total, split_count_total, size_count_total, option, 'total')
  end
end

main
