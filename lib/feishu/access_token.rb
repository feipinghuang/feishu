module Feishu
  class AccessToken
    include HTTParty

    headers 'Content-Type' => 'application/json'

    def initialize
      self.class.base_uri(Feishu.config.uri)
    end

    def tenant_access_token
      Redis.current.get(:tenant_access_token) || _tenant_access_token
    end

    def app_access_token
      Redis.current.get(:app_access_token) || _app_access_token
    end

    def jsapi_ticket
      Redis.current.get(:jsapi_ticket) || _jsapi_ticket
    end

    def clear_cache
      Redis.current.del(:tenant_access_token)
      Redis.current.del(:app_access_token)
      Redis.current.del(:jsapi_ticket)
    end

    def user_access_token(grant_type: 'authorization_code', code:)
      self.class.post(
        '/authen/v1/access_token',
        headers: {
          "Authorization": "Bearer #{AccessToken.new.app_access_token}",
          "Content-Type": 'application/json',
        },
        body: { grant_type: grant_type, code: code }.to_json,
      )
    end

    def refresh_user_access_token(grant_type: 'refresh_token', refresh_token:)
      self.class.post(
        '/authen/v1/refresh_access_token',
        headers: {
          "Authorization": "Bearer #{AccessToken.new.app_access_token}",
          "Content-Type": 'application/json',
        },
        body: { grant_type: grant_type, refresh_token: refresh_token }.to_json,
      )
    end

    private

    def _tenant_access_token
      response =
        self.class.post(
          '/auth/v3/tenant_access_token/internal/',
          body: {
            app_id: Feishu.config.app_id,
            app_secret: Feishu.config.app_secret,
          }.to_json,
        )
      Redis.current.setex(
        :tenant_access_token,
        response['expire'] - 5,
        response['tenant_access_token'],
      )
      response['tenant_access_token']
    end

    def _app_access_token
      response =
        self.class.post(
          '/auth/v3/app_access_token/internal/',
          body: {
            app_id: Feishu.config.app_id,
            app_secret: Feishu.config.app_secret,
          }.to_json,
        )
      Redis.current.setex(
        :tenant_access_token,
        response['expire'] - 5,
        response['tenant_access_token'],
      )
      response['tenant_access_token']
    end

    def _jsapi_ticket
      response =
        self.class.post(
          '/jssdk/ticket/get',
          headers: {
            "Authorization": "Bearer #{AccessToken.new.tenant_access_token}",
            "Content-Type": 'application/json',
          },
        )
      Redis.current.setex(
        :jsapi_ticket,
        response['data']['expire_in'] - 5,
        response['data']['ticket'],
      )
      response['data']['ticket']
    end
  end
end
