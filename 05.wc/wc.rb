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

    print option_l_total_num.to_s.rjust(8) if option[:l] || option == {}
    print option_w_total_num.to_s.rjust(8) if option[:w] || option == {}
    print option_c_total_num.to_s.rjust(8) if option[:c] || option == {}
    puts " total"
  end
end

def option_or_no_option(files, option, argv)
  option_l = files.lines.count.to_s.rjust(8)
  option_w = files.split.size.to_s.rjust(8)
  option_c = files.size.to_s.rjust(8)

  print option_l if option[:l]
  print option_w if option[:w]
  print option_c if option[:c]

  if option == {}
    print option_l
    print option_w
    print option_c
  end

  puts " #{argv[0]}"
end

main
