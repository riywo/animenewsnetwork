require 'data_validator'

class AnimeNewsNetwork::Encyclopedia::Reports
  CONFIG = {
    list:                 { id: 155, params: [:type, :name, :search] },
    anime_series_length:  { id: 177 },
    anime_ratings:        { id: 172 },
    recently_added_anime: { id: 148 },
  }

  def initialize()
    @ann = AnimeNewsNetwork::Encyclopedia.new
  end

  def anime_series_length(args = {})
    params = args.merge(CONFIG[:anime_series_length])
    xml = @ann.get_reports(params)
    list = []
    xml.xpath('//item').each do |item|
      anime = item.xpath('anime')[0]
      title  = anime.text
      id     = anime['href'].match(/id=(\d+)/) { $1.to_i }
      length = item.xpath('nb_episodes')[0].text.to_i
      list << {
        id: id, title: title, length: length
      }
    end
    list
  end
end
