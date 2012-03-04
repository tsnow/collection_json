require File.expand_path('spec/spec_helper')

describe CollectionJson::Template do
  let(:template) {CollectionJson::Template.new(:legs, :eyes)}

  specify do
    template.to_json.should == [
      {name: :legs, value: ""},
      {name: :eyes, value: ""},
    ].to_json
  end
end
