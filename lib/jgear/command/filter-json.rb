require "json"

combined_key = ARGV[0].split(/\./)
filter_pattern = /#{Regexp.escape(ARGV[1])}/

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

  print line if filter_pattern =~ value
end
