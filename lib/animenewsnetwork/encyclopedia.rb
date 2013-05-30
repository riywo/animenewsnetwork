require 'open-uri'
require 'nokogiri'
require 'addressable/uri'
require 'data_validator'

class AnimeNewsNetwork::Encyclopedia
  def initialize(url: 'http://cdn.animenewsnetwork.com/encyclopedia')
    @url = url.freeze
  end

  def get_reports(args = {})
    validator = DataValidator::Validator.new(
      args, {
        id:   { presence: true, numericality: { only_integer: true } },
        type: { presence: true, inclusion: { in: %w(anime manga) } },
      }
    )
    raise ArgumentError, validator.errors unless validator.valid?

    path = '/reports.xml';
    query = args
    Nokogiri::XML(get(path, query))
  end

  def get_details(args = {})
    validator = DataValidator::Validator.new(
      args, {
        id:   { presence: true, numericality: { only_integer: true } },
        type: { presence: true, inclusion: { in: %w(anime manga) } },
      }
    )
    raise ArgumentError, validator.errors unless validator.valid?

    path = '/api.xml';
    query = { args[:type] => args[:id] }
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
