require 'mysql'
require 'json'
require 'digest/sha2'

class Handler
    def run(req)
      @my = Mysql.connect(ENV['mysql_host'], ENV['mysql_user'], ENV['mysql_password'], ENV['mysql_database'])
      json = JSON.parse(req)
      if !user_exists(json["username"], json["email"])
        password = Digest::SHA2::new << json['password']
        stmt = @my.prepare('insert into users (username, password, email, first_name, last_name) values (?, ?, ?, ?, ?)')
        stmt.execute json["username"], password.to_s, json["email"], json["first_name"], json["last_name"]
        return "{'username': #{json["username"]}, 'status': 'created'}"
      else
        return "{'error': 'Username or E-Mail already in use'}"
      end
    end

    def user_exists(username, email)
      @my.query("SELECT username FROM users WHERE username = '#{Mysql.escape_string(username)}' OR email = '#{Mysql.escape_string(email)}'").each do |username|
        return true
      end
      return false
    end
end
