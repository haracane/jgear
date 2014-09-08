require "json"
require "optparse"

inverse_flag = false

op = OptionParser.new

op.on("-v") { inverse_flag = true }

op.parse!(ARGV)

combined_key = ARGV[0].split(/\./)
filter_pattern = /#{ARGV[1]}/

STDIN.each do |line|
  record = JSON.parse(line)
  output_record = {}

  value = record
  combined_key.each do |key|
    if value.respond_to?(key)
      value = value.send(key)
    elsif value.is_a?(Array)
      value = value[key.to_i]
    else
      value = value[key]
    end
    break if value.nil?
  end

  print line if !!(filter_pattern =~ value) ^ inverse_flag
end
