require "jgear/entity"
require "optparse"

reverse_flag = false

op = OptionParser.new

op.on("-r") { reverse_flag = true }

op.parse!(ARGV)

filename = ARGV.shift
key = ARGV.shift

entity = Jgear::Entity.parse_yaml(File.read(filename))
if reverse_flag
  entity.each_pair do |k, v|
    if v == key
      puts k
      break
    end
  end
else
  puts entity[key]
end
