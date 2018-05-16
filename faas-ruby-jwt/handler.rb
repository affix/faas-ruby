require 'jwt'

class Handler
    def run(req)
      begin
        public_key = OpenSSL::PKey::RSA.new(Base64.decode64(ENV['public_key']))
        return JWT.decode req, public_key, true, { algorithm: 'RS256' }
      rescue JWT::DecodeError
        return {'error': 'Failed to Decode JWT'}
      rescue JWT::VerificationError
        return {'error': 'JWT Signature mismatch'}
      end
    end
end
