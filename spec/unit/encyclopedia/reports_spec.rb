require 'webmock/rspec'

describe AnimeNewsNetwork::Encyclopedia::Reports do
  before do
    reports_xml = File.new(File.expand_path('../../../resources/reports_xml_id_177', __FILE__))
    stub_http_request(:get, "cdn.animenewsnetwork.com/encyclopedia/reports.xml")
      .with(query: { id: 177 })
      .to_return(body: reports_xml)
  end

  let(:reports) { AnimeNewsNetwork::Encyclopedia::Reports.new }

  describe "anime_series_length" do
    subject { reports.anime_series_length() }
    it { should be_a Array }
    its(:first) { should eq Hash[id: 15201, title: "Otona Joshi no Anime Time (TV 2)", length: 3] }
  end
end
