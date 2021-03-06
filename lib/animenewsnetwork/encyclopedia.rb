require 'open-uri'
require 'nokogiri'
require 'addressable/uri'
require 'data_validator'

class AnimeNewsNetwork::Encyclopedia
  def initialize(args = {})
    @url = args.has_key?(:url) ? args[:url] : 'http://cdn.animenewsnetwork.com/encyclopedia'
  end

  def get_reports(args = {})
    validator = DataValidator::Validator.new(
      args, {
        id:     { presence: true, numericality: { only_integer: true } },
        type:   { allow_nil: true, inclusion: { in: %w(anime manga) } },
        name:   { allow_nil: true },
        search: { allow_nil: true },
        nskip:  { allow_nil: true, numericality: { only_integer: true } },
        nlist:  { allow_nil: true, format: { with: /^(\d+|all)$/ } },
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
