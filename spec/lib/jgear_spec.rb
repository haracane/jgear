require "spec_helper"
require "jgear"
require "json"

describe Jgear do
  it do
    v = spy
    v.foo
    expect(v).to receive(:bar)
    v.bar
  end
end
