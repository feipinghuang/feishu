module Feishu
  module Api
    module Mina
      def code2session(code)
        post('/mina/v2/tokenLoginValidate', body: { code: code })
      end
    end
  end
end