#!/usr/bin/env ruby

require "jwt"

public_key = OpenSSL::PKey::Rsa.new(Base64.decode64(ENV['PUBLIC_KEY']))
pp JWT.decode ARGV[0], public_key, true, { algorithm: 'RS256' }
