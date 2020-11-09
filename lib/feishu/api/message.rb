module Feishu
  module Api
    module Message
      def send(user_id:, msg_type:, content:)
        post('/send', body: { user_id: user_id, msg_type: msg_type, content: content })
      end
    end
  end
end