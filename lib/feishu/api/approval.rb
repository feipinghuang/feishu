module Feishu
  module Api
    module Approval
      def approval_get(approval_code)
        post('/approval/get', body: { approval_code: approval_code })
      end

      def instance_get(instance_code)
        post('/instance/get', body: { instance_code: instance_code })
      end

      def instance_create(approval_code:, user_id:, form: [], node_approver_user_id_list: nil)
        post(
          '/instance/create',
          body: {
            approval_code: approval_code,
            user_id: user_id,
            form: form,
            node_approver_user_id_list: node_approver_user_id_list
          },
        )
      end

      def instance_search(options)
        post('/instance/search', body: options)
      end

      def file_upload(name:, type:, content:)
        post(
          '/file/upload',
          multipart: true,
          body: { name: name, type: type, content: content },
        )
      end

      def subscribe(approval_code)
        post('/subscription/subscribe', body: { approval_code: approval_code })
      end

      def unsubscribe(approval_code)
        post(
          '/subscription/unsubscribe',
          body: { approval_code: approval_code },
        )
      end
    end
  end
end
