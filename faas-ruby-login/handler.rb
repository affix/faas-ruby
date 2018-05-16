require 'mysql'
require 'jwt'
require 'digest/sha2'

class Handler
    def run(req)
      my = Mysql.connect(ENV['mysql_host'], ENV['mysql_user'], ENV['mysql_password'], ENV['mysql_database'])
      token = nil
      req = JSON.parse(req)
      username = Mysql.escape_string(req['username'])
      my.query("SELECT email, password, username, first_name, last_name FROM users WHERE username = '#{username}'").each do |email, password, username, first_name, last_name|
        digest = Digest::SHA2.new << req['password']
        if digest.to_s == password
          user = {
            email: email,
            first_name: first_name,
            last_name: last_name,
            username: username
          }

          token = generate_jwt(user)
          return "{'username': '#{username}', 'token': '#{token}'}"
        else
          return "{'error': 'Invalid username/password'}"
        end
      end
      return "{'error': 'Invalid username/password'}"
    end

    def generate_jwt(user)
      payload = {
        nbf: Time.now.to_i - 10,
        iat: Time.now.to_i - 10,
        exp: Time.now.to_i + ((60) * 60) * 4,
        user: user
      }

      priv_key = OpenSSL::PKey::RSA.new(Base64.decode64(ENV['private_key']))

      JWT.encode(payload, priv_key, 'RS256')
    end
end
