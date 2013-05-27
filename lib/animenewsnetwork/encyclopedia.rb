require 'open-uri'
require 'nokogiri'
require 'addressable/uri'

class AnimeNewsNetwork::Encyclopedia
  def initialize(url: 'http://cdn.animenewsnetwork.com/encyclopedia')
    @url = url.freeze
  end

  def get_reports(id: nil, type: nil)
    raise ArgumentError if id.nil?
    raise ArgumentError if type.nil?

    path = '/reports.xml';
    query = {
      id:   id,
      type: type,
    }
    Nokogiri::XML(get(path, query))
  end

  def get_details(id: nil, type: nil)
    raise ArgumentError if id.nil?
    raise ArgumentError if type.nil?

    path = '/api.xml';
    query = { type => id }
    Nokogiri::XML(get(path, query))
  end

  private

  def get(path = '', query = {})
    uri = Addressable::URI.parse(@url)
    uri.path += path
    uri.query_values = query
    return open(uri)
  end
end
