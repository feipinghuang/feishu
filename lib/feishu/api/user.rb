module Feishu
  module Api
    module User
      def batch_get_id(mobiles:[], emails: [])
        get('/user/v1/batch_get_id', query: { mobiles: mobiles, emails: emails })
      end

      def get_user_id_by_mobile(mobile)
        res = batch_get_id(mobiles:[mobile])
        res['mobile_users'][mobile].first['user_id']
      end
    end
  end
end