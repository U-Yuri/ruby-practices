# frozen_string_literal: true

require 'optparse'
require 'debug'

def main
  opt = OptionParser.new
  option = {}
  opt.on('-l') { |l| option[:l] = l }
  opt.on('-w') { |w| option[:w] = w }
  opt.on('-c') { |c| option[:c] = c }
  argv = opt.parse(ARGV)

  if argv[0].nil?
    lines = $stdin.read
    option_or_no_option(lines, option, argv)

  else
    option_l_total_num = 0
    option_w_total_num = 0
    option_c_total_num = 0

    argv.each do |file_name|
      file = File.read(file_name)

      option_or_no_option(file, option, argv)

      option_l_total_num += file.lines.count
      option_w_total_num += file.split.size
      option_c_total_num += file.size
    end
    
    print_count(option_l_total_num, option_w_total_num, option_c_total_num, option)
    puts " total"
  end
end

def option_or_no_option(files, option, argv)
  option_l = files.lines.count
  option_w = files.split.size
  option_c = files.size

  print_count(option_l, option_w, option_c, option)
  puts " #{argv[0]}"
end

def print_count(option_l, option_w, option_c, option)
  print option_l.to_s.rjust(8) if option[:l] || option == {}
  print option_w.to_s.rjust(8) if option[:w] || option == {}
  print option_c.to_s.rjust(8) if option[:c] || option == {}
end

main
