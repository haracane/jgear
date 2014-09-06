#!/usr/bin/env ruby

require "json"
require "csv"
require "optparse"

with_header = true

option_parser = OptionParser.new

option_parser.on("--no-header") { with_header = false }

option_parser.parse!(ARGV)

print ARGV.to_csv if with_header

STDIN.each do |l|
  print JSON.parse(l).values_at(*ARGV).map{ |v| v.is_a?(Array)? v.join(" ") : v }.to_csv
end
