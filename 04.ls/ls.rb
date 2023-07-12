# frozen_string_literal: true

require 'optparse'

opt = OptionParser.new
option = {}
opt.on('-a') { |a| option[:a] = a }
opt.parse(ARGV)

def make_cell(rows, cols, files_sorted)
  rows.each do |row|
    cols.each do |col|
      break if files_sorted[row + col * rows.size].nil?

      print files_sorted[row + col * rows.size].ljust(26)
    end

    puts
  end
end

files = Dir.glob('*')
a_option_files = Dir.glob('*', File::FNM_DOTMATCH)
files_sorted = files.sort
a_option_files_sorted = a_option_files.sort

COL_NUM = 3
row_num = (files.size / COL_NUM.to_f).ceil

cols = (0..COL_NUM - 1)
rows = (0..row_num - 1)

if option == { a: true }
  make_cell(rows, cols, a_option_files_sorted)
else
  make_cell(rows, cols, files_sorted)
end
