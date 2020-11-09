require 'feishu/api/message'

module Feishu
  class MessageClient < Feishu::Client
    include Feishu::Api::Message
    
    def initialize
      super
      self.class.base_uri(Feishu.config.message_uri)
    end
  end
end