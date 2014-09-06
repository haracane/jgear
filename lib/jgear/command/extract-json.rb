require "json"
combined_keys = ARGV.map{ |arg| arg.split(/\./) }

STDIN.each do |line|
  record = JSON.parse(line)
  output_record = {}

  combined_keys.each do |combined_key|
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
    output_record[combined_key.join(".")] = value
  end

  puts output_record.to_json
end
