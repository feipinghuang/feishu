require 'feishu/api/user'

module Feishu
  class UserClient < Feishu::Client
    include Feishu::Api::User
    
    def initialize
      super
      self.class.base_uri(Feishu.config.uri)
    end
  end
end