require "json"

keys = ARGV

records = STDIN.map { |line| JSON.parse(line) }

records =
  records.sort do |a, b|
    a_value = keys.map { |key| a[key] || ""}
    b_value = keys.map { |key| b[key] || ""}
    a_value <=> b_value
  end

records.each do |record|
  puts record.to_json
end
