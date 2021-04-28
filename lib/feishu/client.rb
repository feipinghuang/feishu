module Feishu
  class Client
    include HTTParty

    format :json
    debug_output $stdout

    disable_rails_query_string_format

    def initialize
      self.class.default_options.merge!(
        headers: {
          "Authorization": "Bearer #{AccessToken.new.tenant_access_token}",
          "Content-Type": 'application/json',
        },
      )
    end

    def get(path, query: {})
      response = self.class.get(path, query: query)
      handle_response(response.parsed_response)
    rescue Feishu::AccessTokenExpiredError
      AccessToken.new.clear_cache
      retry
    end

    def post(path, multipart: false, body: {})
      response =
        self.class.post(
          path,
          multipart: multipart,
          body: multipart ? body : body.to_json,
        )
      handle_response(response.parsed_response)
    rescue Feishu::AccessTokenExpiredError
      AccessToken.new.clear_cache
      retry
    end

    private

    def handle_response(response)
      case response['code']
      when 0
        response.fetch('data')
      when 99_991_663, 99_991_664, 99_991_661
        raise Feishu::AccessTokenExpiredError
      else
        raise Feishu::ResponseError.new(response['code'], response['msg'])
      end
    end
  end
end
