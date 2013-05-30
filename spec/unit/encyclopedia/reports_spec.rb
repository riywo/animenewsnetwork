require 'webmock/rspec'

describe AnimeNewsNetwork::Encyclopedia::Reports do
  before do
    reports_xml = File.new(File.expand_path('../../../resources/reports_xml_id_177', __FILE__))
    stub_http_request(:get, "cdn.animenewsnetwork.com/encyclopedia/reports.xml")
      .with(query: { id: 177 })
      .to_return(body: reports_xml)

    reports_xml = File.new(File.expand_path('../../../resources/reports_xml_id_155_type_anime', __FILE__))
    stub_http_request(:get, "cdn.animenewsnetwork.com/encyclopedia/reports.xml")
      .with(query: { id: 155, type: 'anime' })
      .to_return(body: reports_xml)

    reports_xml = File.new(File.expand_path('../../../resources/reports_xml_id_172', __FILE__))
    stub_http_request(:get, "cdn.animenewsnetwork.com/encyclopedia/reports.xml")
      .with(query: { id: 172 })
      .to_return(body: reports_xml)

    reports_xml = File.new(File.expand_path('../../../resources/reports_xml_id_148', __FILE__))
    stub_http_request(:get, "cdn.animenewsnetwork.com/encyclopedia/reports.xml")
      .with(query: { id: 148 })
      .to_return(body: reports_xml)
  end

  let(:reports) { AnimeNewsNetwork::Encyclopedia::Reports.new }

  describe "anime_series_length" do
    subject { reports.anime_series_length() }
    it { should be_a Array }
    its(:first) { should eq Hash[
      id:                   15201,
      title:                "Otona Joshi no Anime Time (TV 2)",
      episodes:             3,
      start_date:           "2013-03-10",
      end_date:             "2013-03-24",
      days:                 15,
      avg_days_between_eps: 7.0,
    ] }
  end

  describe "anime_list" do
    subject { reports.anime_list() }
    it { should be_a Array }
    its(:first) { should eq Hash[
      id:   15347,
      gid:  1743357399,
      name: "Outbreak Company",
      type: "TV",
    ] }
  end

  describe "anime_ratings" do
    subject { reports.anime_ratings() }
    it { should be_a Array }
    its(:first) { should eq Hash[
      id:               11770,
      title:            "Steins;Gate (TV)",
      votes:            2733,
      seen:             3903,
      straight_average: 9.230199813842773,
      weighted_average: 9.122900009155273,
      bayesian_average: 9.116583824157715,
    ] }
  end

  describe "anime_added_recently" do
    subject { reports.anime_added_recently() }
    it { should be_a Array }
    its(:first) { should eq Hash[
      id:         15359,
      title:      "Arpeggio of Blue Steel (TV)",
      date_added: "2013-05-29 14:29:49",
    ] }
  end
end
