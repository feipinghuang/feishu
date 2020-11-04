module Feishu
  module Api
    module User
      def batch_get_id(mobiles:[], emails: [])
        get('/user/v1/batch_get_id', query: { mobiles: mobiles, emails: emails })
      end
    end
  end
end