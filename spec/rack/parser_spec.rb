describe CollectionJson::Rack::Parser do
  let(:parser) do
    CollectionJson::Rack::Parser.new '{"a": 1, "c": "1"}'
  end

  describe "#initialize" do
    specify do
      ->{CollectionJson::Rack::Parser.new ""}.should raise_error CollectionJson::InvalidJsonError
    end
  end

  describe "#json" do
    specify do
      parser.json.should == {"a" => 1, "c" => "1"}
    end
  end

  describe "#valid?" do
    specify do
      parser.should_not be_valid
    end
  end
end
