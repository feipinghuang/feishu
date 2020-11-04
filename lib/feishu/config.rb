require 'anyway'

module Feishu
  class Config < Anyway::Config
    attr_config :app_id,
                :app_secret,
                :encrypt_key,
                :verification_token,
                :uri
  end
end
