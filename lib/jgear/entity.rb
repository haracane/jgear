require "json"
require "yaml"

module Jgear
  class Entity
    def self.parse_json(json)
      self.new(JSON.parse(json))
    end

    def self.parse_yaml(yaml)
      self.new(YAML.load(yaml))
    end

    def initialize(params)
      @params = JSON.parse(params.to_json)
    end

    def [](key)
      combined_key = key.to_s.split(/\./)
      value = @params

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
      value
    end

    def to_json
      @params.to_json
    end

    def each_pair(&block)
      @params.each_pair(&block)
    end
  end
end
