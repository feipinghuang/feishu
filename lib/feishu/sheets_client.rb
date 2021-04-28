require 'feishu/api/sheets'

module Feishu
  class SheetsClient < Feishu::Client
    include Feishu::Api::Sheets

    def initialize
      self.class.default_options.merge!(
        headers: {
          "Authorization": "Bearer #{AccessToken.new.tenant_access_token}",
          "Content-Type": 'application/json; charset=utf-8',
        },
      )
      self.class.base_uri(Feishu.config.uri)
    end
  end
end
