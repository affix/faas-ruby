#!/usr/bin/env ruby
require "jwt"

payload = {
  nbf: Time.now.to_i - 10,
  iat: Time.now.to_i - 10,
  exp: Time.now.to_i + ((60) * 60) * 4,
  user: {
    username: ARGV[0],
  }
}

priv_key = OpenSSL::PKey::RSA.new(Base64.decode64(ENV['PRIVATE_KEY']))

pp JWT.encode(payload, priv_key, 'RS256')
