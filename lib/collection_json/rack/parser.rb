module CollectionJson::Rack
  class Parser
    attr_reader :json

    def initialize json_string
      @json = JSON.parse json_string
    rescue JSON::ParserError => e
      raise CollectionJson::InvalidJsonError.new "Couldn't parse: <#{json_string}>, #{e.message}"
    end

    def valid?
      false
    end
  end
end
