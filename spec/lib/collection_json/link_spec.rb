describe CollectionJson::Link do
  let(:link) do
    CollectionJson::Link.new href: "http://localhost:3000/mutants/"
  end

  specify do
    ->{CollectionJson::Link.new(href: "asdf:").
              should raise_error CollectionJson::InvalidUriError}
  end

  specify do
    ->{CollectionJson::Link.new(href: "http://www.google.com").
       should_not raise_error CollectionJson::InvalidUriError}
  end

  describe "#valid?" do
    specify {link.should be_valid}
  end
end
