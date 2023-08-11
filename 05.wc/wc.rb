# frozen_string_literal: true

require 'optparse'

def main
  option, file_names = make_options

  if file_names[0].nil?
    count_and_print_stdin(option)
  else
    count_and_print_files(file_names, option)
  end
end

def print_count(option_l, option_w, option_c, option)
  print option_l.to_s.rjust(8) if option[:l] || option.empty?
  print option_w.to_s.rjust(8) if option[:w] || option.empty?
  print option_c.to_s.rjust(8) if option[:c] || option.empty?
end

def count(file_contents)
  option_l = file_contents.lines.count
  option_w = file_contents.split.size
  option_c = file_contents.size
  [option_l, option_w, option_c]
end

def make_options
  opt = OptionParser.new
  option = {}
  opt.on('-l') { |l| option[:l] = l }
  opt.on('-w') { |w| option[:w] = w }
  opt.on('-c') { |c| option[:c] = c }
  file_names = opt.parse(ARGV)
  [option, file_names]
end

def count_and_print_files(file_names, option)
  option_l_total_num = 0
  option_w_total_num = 0
  option_c_total_num = 0

  file_names.each do |file_name|
    file_contents = File.read(file_name)
    option_l, option_w, option_c = count(file_contents)
    print_count(option_l, option_w, option_c, option)
    puts " #{file_name}"
    option_l_total_num += option_l
    option_w_total_num += option_w
    option_c_total_num += option_c
  end

  print_count(option_l_total_num, option_w_total_num, option_c_total_num, option)
  puts ' total'
end

def count_and_print_stdin(option)
  file_contents = $stdin.read
  option_l, option_w, option_c = count(file_contents)
  print_count(option_l, option_w, option_c, option)
  puts
end

main
