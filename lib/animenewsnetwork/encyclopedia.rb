require 'open-uri'
require 'nokogiri'
require 'addressable/uri'

class AnimeNewsNetwork::Encyclopedia
  def initialize(url: 'http://cdn.animenewsnetwork.com/encyclopedia')
    @uri = Addressable::URI.parse(url)
  end

  def get_reports(id: nil, type: nil)
    @uri.path += '/reports.xml';
    @uri.query_values = {
      id:   id,
      type: type,
    }
    Nokogiri::XML(open(@uri))
  end
end
