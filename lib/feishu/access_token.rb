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

    def clear_cache
      Redis.current.del(:tenant_access_token)
      Redis.current.del(:app_access_token)
    end

    private

    def _tenant_access_token
      response = self.class.post('/auth/v3/tenant_access_token/internal/', body: {
        app_id: Feishu.config.app_id,
        app_secret: Feishu.config.app_secret
      }.to_json)
      Redis.current.setex(:tenant_access_token, response['expire'] - 5, response['tenant_access_token'])
      response['tenant_access_token']
    end

    def _app_access_token
      response = self.class.post('/auth/v3/app_access_token/internal/', body: {
        app_id: Feishu.config.app_id,
        app_secret: Feishu.config.app_secret
      }.to_json)
      Redis.current.setex(:tenant_access_token, response['expire'] - 5, response['tenant_access_token'])
      response['tenant_access_token']
    end
  end
end
