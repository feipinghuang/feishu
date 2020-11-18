module Feishu
  module Api
    module User
      def batch_get_id(mobiles: [], emails: [])
        get('/user/v1/batch_get_id', query: { mobiles: mobiles, emails: emails })
      end

      def batch_get(employee_ids: [], open_ids: [])
        get('/contact/v1/user/batch_get', query: { employee_ids: employee_ids, open_ids: open_ids })
      end

      def get_user_id_by_mobile(mobile)
        res = batch_get_id(mobiles:[mobile])
        res['mobile_users'][mobile].first['user_id']
      end

      def get_user_id_by_union_id(union_id)
        res = get('/user/v1/union_id/batch_get/list', query: { union_ids: [union_id] })
        res['user_infos'][union_id]['user_id']
      end
    end
  end
end