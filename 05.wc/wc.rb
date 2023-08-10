# frozen_string_literal: true

require 'optparse'

def main
  _opt, option, argv = set_option

  if argv[0].nil?
    deta = $stdin.read
    option_l, option_w, option_c, show_count = a(deta, argv, option)

  else
    option_l_total_num = 0
    option_w_total_num = 0
    option_c_total_num = 0

    argv.each do |file_name|
      deta = File.read(file_name)
      option_l, option_w, option_c, show_count = a(deta, file_name, option)

      option_l_total_num += option_l
      option_w_total_num += option_w
      option_c_total_num += option_c
    end

    print_count(option_l_total_num, option_w_total_num, option_c_total_num, option)
    puts ' total'
  end
end

def print_count(option_l, option_w, option_c, option)
  print option_l.to_s.rjust(8) if option[:l] || option == {}
  print option_w.to_s.rjust(8) if option[:w] || option == {}
  print option_c.to_s.rjust(8) if option[:c] || option == {}
end

def a(deta, file_name, option)
  option_l = deta.lines.count
  option_w = deta.split.size
  option_c = deta.size
  show_count = print_count(option_l, option_w, option_c, option)
  puts " #{file_name}"
  [option_l, option_w, option_c, show_count]
end

def set_option
  opt = OptionParser.new
  option = {}
  opt.on('-l') { |l| option[:l] = l }
  opt.on('-w') { |w| option[:w] = w }
  opt.on('-c') { |c| option[:c] = c }
  argv = opt.parse(ARGV)
  [opt, option, argv]
end

main
