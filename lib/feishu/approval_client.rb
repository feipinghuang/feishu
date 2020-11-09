require 'feishu/api/approval'

module Feishu
  class ApprovalClient < Client
    include Feishu::Api::Approval
    
    def initialize
      super
      self.class.base_uri(Feishu.config.approval_uri)
    end
  end
end