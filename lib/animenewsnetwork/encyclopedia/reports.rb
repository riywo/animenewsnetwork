class AnimeNewsNetwork::Encyclopedia::Reports
  CONFIG = {
    anime_list:           { id: 155, type: 'anime' },
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
    xml.xpath('//item').map do |item|
      data = {}
      anime = item.xpath('anime')[0]
      data[:id] = anime['href'].match(/id=(\d+)/) { $1.to_i }
      data[:title] = anime.text
      data[:episodes] = item.xpath('nb_episodes')[0].text.to_i
      data[:start_date], data[:end_date] =
        item.xpath('production_date')[0].text.match(/([\d\-]+) to ([\d\-]+)/) { [$1, $2] }
      data
    end
  end

  def anime_list(args = {})
    params = args.merge(CONFIG[:anime_list])
    xml = @ann.get_reports(params)
    xml.xpath('//item').map do |item|
      data = {}
      data[:id] = item.xpath('id').text.to_i
      data[:gid] = item.xpath('gid').text.to_i
      data[:name] = item.xpath('name').text
      data[:type] = item.xpath('type').text
      data
    end
  end
end
