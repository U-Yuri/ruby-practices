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
    option_l = lines.lines.count
    option_w = lines.split.size
    option_c = lines.size

    print_count(option_l, option_w, option_c, option)
    puts " #{argv[0]}"

  else
    option_l_total_num = 0
    option_w_total_num = 0
    option_c_total_num = 0

    argv.each do |file_name|
      file = File.read(file_name)

      option_l = file.lines.count
      option_w = file.split.size
      option_c = file.size

      print_count(option_l, option_w, option_c, option)
      puts " #{argv[0]}"

      option_l_total_num += option_l
      option_w_total_num += option_w
      option_c_total_num += option_c
    end
    
    print_count(option_l_total_num, option_w_total_num, option_c_total_num, option)
    puts " total"
  end
end

def print_count(option_l, option_w, option_c, option)
  print option_l.to_s.rjust(8) if option[:l] || option == {}
  print option_w.to_s.rjust(8) if option[:w] || option == {}
  print option_c.to_s.rjust(8) if option[:c] || option == {}
end

main
