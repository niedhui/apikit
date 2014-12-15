
describe Apikit::Client do
  let(:api_endpoint) { "http://awesome.api"}
  let(:client) { Apikit::Client.new(api_endpoint) }
  let(:path) { '/ping.json' }
  let(:stub_ping) { stub_request(:get, api_endpoint + path) }

  describe ".get" do

    it "get parsed result " do
      stub_get = stub_ping.to_return(json_response({ok: true}))
      result = client.get(path)
      expect(result.ok).to eq(true)
    end

    it "get string result (without json response header)" do
      stub_get = stub_ping.to_return(body: {ok: true}.to_json)
      result = client.get(path)
      expect(result).to eq("{\"ok\":true}")
    end

    it "handle query parameters" do
      stub_get = stub_ping.with(query: {timeout: 5}).to_return(body: {ok: true}.to_json)
      result = client.get(path, query: {timeout: 5})
      expect(result).to eq("{\"ok\":true}")
    end

    it "handle request fail" do
      stub_get = stub_ping.to_return(json_response({ok: false}, {status: [500, "Internal Server Error"]}))
      result = client.get(path)
      expect(result.ok).to eq(false)
    end

    it "handle request fail, when invalid json, parsed response is extract what the server returns" do
      stub_get = stub_ping.to_return(json_response("OMG, WTF", {status: [500, "Internal Server Error"]}))
      result = client.get(path)
      expect(result).to eq("OMG, WTF")
    end

  end

  describe ".post" do
    it "handle query parameters" do
      stub_get = stub_request(:post, api_endpoint + path).with(query: {timeout: 5}).to_return(body: {ok: true}.to_json)
      result = client.post(path, query: {timeout: 5})
      expect(result).to eq("{\"ok\":true}")
    end
  end

  describe "options[:config]" do
    let(:config) do
      Apikit::Config.new.tap do |config|
        config.config_faraday do |conn|
          conn.use Faraday::Response::RaiseError
        end
      end
    end
    let(:client) { Apikit::Client.new(api_endpoint, config) }

    it "should use the raise error middleware" do
      stub_get = stub_ping.to_return(json_response({ok: false}, {status: [500, "Internal Server Error"]}))
      expect { result = client.get(path) }.to raise_error(Faraday::ClientError)
    end

  end



end
