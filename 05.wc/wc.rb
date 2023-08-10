# frozen_string_literal: true

require 'optparse'

def main
  option, argv = make_option

  if argv[0].nil?
    count_and_print_stdin(option)
  else
    count_and_print_files(argv, option)
  end
end

def print_count(option_l, option_w, option_c, option)
  print option_l.to_s.rjust(8) if option[:l] || option.empty?
  print option_w.to_s.rjust(8) if option[:w] || option.empty?
  print option_c.to_s.rjust(8) if option[:c] || option.empty?
end

def count(deta)
  option_l = deta.lines.count
  option_w = deta.split.size
  option_c = deta.size
  [option_l, option_w, option_c]
end

def make_option
  opt = OptionParser.new
  option = {}
  opt.on('-l') { |l| option[:l] = l }
  opt.on('-w') { |w| option[:w] = w }
  opt.on('-c') { |c| option[:c] = c }
  argv = opt.parse(ARGV)
  [option, argv]
end

def count_and_print_files(argv, option)
  option_l_total_num = 0
  option_w_total_num = 0
  option_c_total_num = 0

  argv.each do |file_name|
    deta = File.read(file_name)
    option_l, option_w, option_c = count(deta)
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
  deta = $stdin.read
  option_l, option_w, option_c = count(deta)
  print_count(option_l, option_w, option_c, option)
  puts
end

main
