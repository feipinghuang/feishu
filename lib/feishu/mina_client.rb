require 'feishu/api/mina'

module Feishu
  class MinaClient < Feishu::Client
    include Feishu::Api::Mina

    def initialize
      self.class.default_options.merge!(
        headers: {
          "Authorization": "Bearer #{AccessToken.new.app_access_token}",
          "Content-Type": 'application/json',
        },
      )
      self.class.base_uri(Feishu.config.uri)
    end
  end
end
