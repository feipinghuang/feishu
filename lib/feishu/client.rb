require 'feishu/api/user'

module Feishu
  class Client
    include HTTParty
    include Feishu::Api::User

    debug_output $stdout
    format :json

    query_string_normalizer proc { |query|
      query.map do |key, value|
        value.map {|v| "#{key}=#{v}"}
      end.join('&')
    }

    def initialize
      self.class.base_uri(Feishu.config.uri)
      self.class.default_options.merge!(headers: { "Authorization": "Bearer #{AccessToken.new.tenant_access_token}" })
    end

    def get(path, query: {})
      response = self.class.get(path, query: query)
      handle_response(response.parsed_response)
    end

    def post(path, body: {})
      response = self.class.get(path, query: query)
      handle_response(response.parsed_response)
    end

    private
    def handle_response(response)
      case response['code']
      when 0
        response['data']
      when 99991663, 99991664
        raise Feishu::AccessTokenExpiredError
      else
        raise Feishu::ResponseError.new(response['code'], response['msg'])
      end
    end
  end
end
