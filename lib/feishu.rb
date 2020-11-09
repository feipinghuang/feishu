require 'httparty'
require 'redis'
require 'feishu/version'

module Feishu
  class AccessTokenExpiredError < RuntimeError; end
  class ResultErrorException < RuntimeError; end
  class ResponseError < StandardError
    attr_reader :error_code
    def initialize(errcode, errmsg='')
      @error_code = errcode
      super "(#{error_code}) #{errmsg}"
    end
  end
  
  module_function

  def config
    @config ||= begin
      require 'feishu/config'
      Config.new
    end
  end

  def cipher
    @cipher ||= begin
      require 'feishu/cipher'
      Cipher.new(config.encrypt_key)
    end
  end
end

require 'feishu/access_token'
require 'feishu/client.rb'
require 'feishu/user_client'
require 'feishu/approval_client'
require 'feishu/message_client'