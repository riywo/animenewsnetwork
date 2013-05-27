require 'open-uri'
require 'nokogiri'

class AnimeNewsNetwork::Encyclopedia
  def initialize()
  end

  def get_reports(*args)
    Nokogiri::XML(open("http://cdn.animenewsnetwork.com/encyclopedia/reports.xml?id=155&type=anime"))
  end
end
