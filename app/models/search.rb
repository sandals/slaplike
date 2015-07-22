class Search
  attr_reader :terms

  def initialize(args = {})
    @terms = args.fetch(:terms, 'Rick Astley')
  end

  def results
    lfm = Lastfm::Client.new
    yt = Youtube::Client.new
    
    results = {}

    similar_artists = lfm.get_similar_artists(@terms)
    
    similar_artists = similar_artists.collect do |artist|
      if artist['match'].to_f > 0.50
        artist
      end
    end.compact

    similar_artists.each do |artist|
      results[artist] = yt.search(term: artist['name'], max_results: 3)
    end

    results
  end
end
