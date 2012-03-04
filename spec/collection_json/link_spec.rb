describe CollectionJson::Link do
  let(:link) do
    CollectionJson::Link.new href: "http://localhost:3000/mutants/", rel: "mutants"
  end

  specify do
    ->{CollectionJson::Link.new(href: "asdf:", rel: "mutants").
              should raise_error CollectionJson::InvalidUriError}
  end

  specify do
    ->{CollectionJson::Link.new(href: "http://www.google.com", rel: "search").
       should_not raise_error CollectionJson::InvalidUriError}
  end

  describe "#valid?" do
    specify {link.should be_valid}
  end
end
