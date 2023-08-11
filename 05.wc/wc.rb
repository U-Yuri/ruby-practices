# frozen_string_literal: true

require 'optparse'

def main
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
  file_contents = $stdin.read
  option_l, option_w, option_c = count(file_contents)
  print_count(option_l, option_w, option_c, option)
  puts
end

def count(file_contents)
  option_l = file_contents.lines.count
  option_w = file_contents.split.size
  option_c = file_contents.size
  [option_l, option_w, option_c]
end

def print_count(option_l, option_w, option_c, option)
  print option_l.to_s.rjust(8) if option[:l] || option.empty?
  print option_w.to_s.rjust(8) if option[:w] || option.empty?
  print option_c.to_s.rjust(8) if option[:c] || option.empty?
end

def count_and_print_files(file_names, option)
  lines_count_total = 0
  split_count_total = 0
  size_count_total = 0

  file_names.each do |file_name|
    file_contents = File.read(file_name)
    option_l, option_w, option_c = count(file_contents)
    print_count(option_l, option_w, option_c, option)
    puts " #{file_name}"
    lines_count_total += option_l
    split_count_total += option_w
    size_count_total += option_c
  end

  print_count(lines_count_total, split_count_total, size_count_total, option)
  puts ' total'
end

main
