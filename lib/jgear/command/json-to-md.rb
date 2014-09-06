#!/usr/bin/env ruby

require "json"
require "optparse"

with_header = true
with_number = true
headers = nil

option_parser = OptionParser.new

option_parser.on("--no-header") { with_header = false }
option_parser.on("--no-number") { with_number = false }

option_parser.on("--header NAMES", String) do |joined_headers|
  headers = joined_headers.split(/,/)
end

option_parser.parse!(ARGV)

if with_header
  headers ||= ARGV.clone
  headers.unshift "#" if with_number
  puts "| #{headers.join(" | ")} |"
  puts "| #{headers.map {|v| "---"}.join(" | ")} |"
end

number = 1

STDIN.each do |l|
  records = JSON.parse(l).values_at(*ARGV).map{ |v| v.is_a?(Array)? v.join(" ") : v }
  records.unshift number if with_number
  puts "| #{records.join(" | ")} |"
  number += 1
end
