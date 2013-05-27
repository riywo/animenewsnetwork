require 'webmock/rspec'

describe AnimeNewsNetwork::Encyclopedia do
  before do
    reports_xml = File.new(File.expand_path('../../resources/reports_xml_id_155_type_anime', __FILE__))
    stub_http_request(:get, "cdn.animenewsnetwork.com/encyclopedia/reports.xml")
      .with(query: { id: 155, type: "anime" })
      .to_return(body: reports_xml)
  end

  let(:ann) { AnimeNewsNetwork::Encyclopedia.new }

  describe "GET reports" do
    subject { ann.get_reports(id: 155, type: 'anime') }
    it { should be_a Nokogiri::XML::Document }
  end
end
