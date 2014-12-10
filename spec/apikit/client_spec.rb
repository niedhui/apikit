
describe Apikit::Client do
  let(:api_endpoint) { "http://awesome.api"}
  let(:client) { Apikit::Client.new(api_endpoint) }

  describe ".get" do
    let(:path) { '/ping.json' }

    it "get parsed result " do
      stub_get = stub_request(:get, api_endpoint + path).to_return(json_response({ok: true}))
      result = client.get(path)
      expect(result.ok).to eq(true)
    end

    it "get string result (without json response header)" do
      stub_get = stub_request(:get, api_endpoint + path).to_return(body: {ok: true}.to_json)
      result = client.get(path)
      expect(result).to eq("{\"ok\":true}")
    end

  end



end
