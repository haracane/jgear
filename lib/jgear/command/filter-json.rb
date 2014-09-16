require "json"
require "optparse"
require "jgear/entity"

inverse_flag = false
strict_flag = false

op = OptionParser.new

op.on("-v") { inverse_flag = true }
op.on("--strict") { strict_flag = true }

op.parse!(ARGV)

key = ARGV[0]
filter_pattern = /#{ARGV[1]}/
filter_text = ARGV[1]

STDIN.each do |line|
  entity = Jgear::Entity.parse_json(line)
  value = entity[key]
  if strict_flag
    result_flag = (filter_text == value)
  else
    result_flag =  !!(filter_pattern =~ value)
  end
  print line if result_flag ^ inverse_flag
end
