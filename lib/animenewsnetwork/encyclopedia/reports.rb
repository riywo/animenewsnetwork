class AnimeNewsNetwork::Encyclopedia::Reports
  CONFIG = {
    anime_list:           { id: 155, type: 'anime' },
    anime_series_length:  { id: 177 },
    anime_ratings:        { id: 172 },
    anime_added_recently: { id: 148 },
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
      data[:days] = item.xpath('nb_days')[0].text.to_i
      data[:avg_days_between_eps] = item.xpath('avg_days_between_eps')[0].text.to_f
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

  def anime_ratings(args = {})
    params = args.merge(CONFIG[:anime_ratings])
    xml = @ann.get_reports(params)
    xml.xpath('//item').map do |item|
      data = {}
      anime = item.xpath('anime')[0]
      data[:id] = anime['href'].match(/id=(\d+)/) { $1.to_i }
      data[:title] = anime.text
      data[:votes] = item.xpath('nb_votes')[0].text.to_i
      data[:seen] = item.xpath('nb_seen')[0].text.to_i
      data[:straight_average] = item.xpath('straight_average')[0].text.to_f
      data[:weighted_average] = item.xpath('weighted_average')[0].text.to_f
      data[:bayesian_average] = item.xpath('bayesian_average')[0].text.to_f
      data
    end
  end

  def anime_added_recently(args = {})
    params = args.merge(CONFIG[:anime_added_recently])
    xml = @ann.get_reports(params)
    xml.xpath('//item').map do |item|
      data = {}
      anime = item.xpath('anime')[0]
      data[:id] = anime['href'].match(/id=(\d+)/) { $1.to_i }
      data[:title] = anime.text
      data[:date_added] = item.xpath('date_added')[0].text
      data
    end
  end
end
