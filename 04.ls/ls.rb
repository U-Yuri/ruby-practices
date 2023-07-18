# frozen_string_literal: true
 require 'debug'
require 'optparse'

opt = OptionParser.new
option = {}
opt.on('-a') { |a| option[:a] = a }
opt.on('-r') { |r| option[:r] = r }
opt.on('-l') { |l| option[:l] = l }
opt.parse(ARGV)

def make_cell(rows, cols, files_ordered, option)
  rows.each do |row|
    cols.each do |col|
      break if files_ordered[row + col * rows.size].nil?
    
      print files_ordered[row + col * rows.size].ljust(26)
    end

    puts
  end
end

def block_sum(files)
  block_total = 0
  files.each do |file|
    block_num = File.stat("#{file}").blocks
    block_total += block_num
  end
  puts "total #{block_total}"
end

def option_l(files)
  block_sum(files)
  files.each do |file|
    if File.ftype("#{file}") == "directory"
      print "d"
    else
      print "-"
    end
    
    file_path = File.stat("#{file}")
    permission = file_path.mode.to_s(2)

    if (permission.to_i(2) & 1 << 8) == 0
      debugger
      print "-"
    elsif (permission.to_i(2) & 1 << 8) == 1 << 8
      print "r"
    end

    if (permission.to_i(2) & 1 << 7) == 0
      print "-"
    elsif (permission.to_i(2) & 1 << 7) == 1 << 7
      print "w"
    end

    if (permission.to_i(2) & 1 << 6) == 0
      print "-"
    elsif (permission.to_i(2) & 1 << 6) == 1 << 6
      print "x"
    end

    if (permission.to_i(2) & 1 << 5) == 0
      print "-"
    elsif (permission.to_i(2) & 1 << 5) == 1 << 5
      print "r"
    end

    if (permission.to_i(2) & 1 << 4) == 0
      print "-"
    elsif (permission.to_i(2) & 1 << 4) == 1 << 4
      print "w"
    end

    if (permission.to_i(2) & 1 << 3) == 0
      print "-"
    elsif (permission.to_i(2) & 1 << 3) == 1 << 3
      print "x"
    end

    if (permission.to_i(2) & 1 << 2) == 0
      print "-"
    elsif (permission.to_i(2) & 1 << 2) == 1 << 2
      print "r"
    end

    if (permission.to_i(2) & 1 << 1) == 0
      print "-"
    elsif (permission.to_i(2) & 1 << 1) == 1 << 1
      print "w"
    end

    if (permission.to_i(2) & 1 << 0) == 0
      print "-"
    elsif (permission.to_i(2) & 1 << 0) == 1 << 0
      print "x"
    end
    
    link = file_path.nlink
    user = Etc.getpwuid(file_path.uid).name
    group = Etc.getgrgid(file_path.gid).name
    size = file_path.size
    time_stanp = file_path.mtime.to_a
    hour = sprintf("%02d", time_stanp[2])
    minutes = sprintf("%02d", time_stanp[1])

    print "#{link}".rjust(3)
    print "#{user}".rjust(8)
    print "#{group}".rjust(7)
    print "#{size}".rjust(6)
    print "#{time_stanp[4]}".rjust(3)
    print "#{time_stanp[3]}".rjust(3)
    print "#{hour}:#{minutes}".rjust(6)
    print " #{file}"
    puts
  end
end

flags = option[:a] ? File::FNM_DOTMATCH : 0
files = Dir.glob('*', flags)

files_ordered = option[:r] ? files.reverse : files.sort

COL_NUM = 3
row_num = (files.size / COL_NUM.to_f).ceil

cols = (0..COL_NUM - 1)
rows = (0..row_num - 1)

if option[:l]
  # debugger
  option_l(files)
else
  make_cell(rows, cols, files_ordered, option)
end
