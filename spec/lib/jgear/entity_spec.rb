require "spec_helper"
require "jgear/entity"

describe Jgear::Entity do
  subject { Jgear::Entity.new({user: {name: "alice"}, tweets: [{text: "hello"}]}) }

  describe "[]" do
    it { expect(subject["user.name"]).to eq "alice" }
    it { expect(subject["tweets.0.text"]).to eq "hello" }
  end
end
