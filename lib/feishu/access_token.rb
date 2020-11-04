module Feishu
  class AccessToken
    include HTTParty
    
    headers 'Content-Type' => 'application/json'

    def initialize
      self.class.base_uri(Feishu.config.uri)
    end

    def tenant_access_token
      Redis.current.get(:tenant_access_token) || refresh
    end

    def refresh
      response = self.class.post('/auth/v3/tenant_access_token/internal/', body: {
        app_id: Feishu.config.app_id,
        app_secret: Feishu.config.app_secret
      }.to_json)
      Redis.current.setex(:tenant_access_token, response['expire'] - 5, response['tenant_access_token'])
      response['tenant_access_token']
    end
  end
end
