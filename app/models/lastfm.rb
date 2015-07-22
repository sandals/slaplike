module Lastfm
  require 'json'
  require 'httparty'

  class Api
    API_KEY = '0be8f64862e8ae344707c16c6764b8e2'

    def initialize(args = {})
      @format = args.fetch(:format, :json)
    end

    def get(args)
      HTTParty.get(endpoint_uri(args))
    end

    private

    def endpoint_uri(args)
      base_uri + '?' + args.merge(required_params).collect { |k, v|
        "#{k.to_s}=#{v.to_s}"
      }.join('&')
    end

    def required_params
      { api_key: API_KEY, format: @format }
    end

    def base_uri
      'http://ws.audioscrobbler.com/2.0/'
    end
  end

  class Client
    attr_reader :api, :parser

    def initialize(args = {})
      @parser = args.fetch(:parser, JSON)
      @api = Lastfm::Api.new(format: args.fetch(:format, :json))
    end

    def get_similar_artists(to)
      params = {
        method: 'artist.getsimilar',
        artist: to
      }

      response = api.get(params)
      response = parser.parse(response.body)
      response['similarartists']['artist']
    end
  end
end
