module WorkflowsApiClient
  class AuthenticationHeaders
    attr_accessor :api_key, :api_secret, :key, :digest

    def initialize
      @api_key = WorkflowsApiClient.config[:consumer_api_key]
      @api_secret = WorkflowsApiClient.config[:consumer_api_secret]
    end

    def perform
      validate_config
      set_key_and_digest
      self
    end

    private

    def validate_config
      return if config_present?
      api_key_and_secret_nil? ? invalid_configuration_error : evaluate_invalid_config
    end

    def config_present?
      api_key.present? && api_secret.present?
    end

    def api_key_and_secret_nil?
      api_key.blank? && api_secret.blank?
    end

    def evaluate_invalid_config
      invalid_config = consumer_config_hash.select { |_k, v| v.blank? }
      invalid_configuration_error(invalid_config.keys[0])
    end

    def consumer_config_hash
      WorkflowsApiClient.config.select do |key, _value|
        %i[consumer_api_key consumer_api_secret].include?(key)
      end
    end

    def invalid_configuration_error(error_message = nil)
      both_message = 'consumer_api_key and consumer_api_secret'
      error_message.blank? ? config_error(both_message) : config_error(error_message)
    end

    def config_error(error_message)
      raise WorkflowsApiClient::Exceptions::InvalidConfiguration, error_message
    end

    def set_key_and_digest
      nonce = Time.now.to_i
      auth_key = "#{api_key}:#{nonce}"
      digest_method = OpenSSL::Digest.new('SHA256')
      hash = OpenSSL::HMAC.digest(digest_method, api_secret, auth_key)
      @digest = Base64.strict_encode64(hash)
      @key = auth_key
    end
  end
end
