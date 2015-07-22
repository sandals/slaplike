require 'google/api_client'

module Youtube
  class Api
    attr_reader :client, :youtube

    API_KEY = 'AIzaSyAIKGcAE_b_H0b1ovwSE4TZoSvbhsjJ-7s'

    def initialize(args = {})
      @client = Google::APIClient.new(
        key: API_KEY,
        authorization: nil,
        application_name: $PROGRAM_NAME,
        application_version: '1.0.0'
      )

      @youtube = client.discovered_api('youtube', 'v3')
    end

    def get(args)
      client.execute!(
        api_method: args[:method],
        parameters: {
          part: args.fetch(:part, 'snippet'),
          q: args[:q],
          maxResults: args[:max_results]
        }
      )
    end
  end

  class Client
    def initialize(args = {})
      @api = Youtube::Api.new
    end

    def search(args = {})
      response = @api.get({
        method: @api.youtube.search.list,
        q: args.fetch(:term, 'Never gonna give you up'),
        max_results: args.fetch(:max_results, 5)
      })

      videos = []

      response.data.items.each do |result|
        case result.id.kind
        when 'youtube#video'
          videos << result.id.videoId
        end
      end

      videos
    end
  end
end
