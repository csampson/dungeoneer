# TODO Lifted from Rails master, once this is released switch to the ActiveRecord version
module SecureToken
  extend ActiveSupport::Concern

  module ClassMethods
    # Example using has_secure_token
    #
    #   # Schema: User(token:string, auth_token:string)
    #   class User < ActiveRecord::Base
    #     has_secure_token
    #     has_secure_token :auth_token
    #   end
    #
    #   user = User.new
    #   user.save
    #   user.token # => "pX27zsMN2ViQKta1bGfLmVJE"
    #   user.auth_token # => "77TMHrHJFvFDwodq8w7Ev2m7"
    #   user.regenerate_token # => true
    #   user.regenerate_auth_token # => true
    #
    # SecureRandom::base58 is used to generate the 24-character unique token, so collisions are highly unlikely.
    #
    # Note that it's still possible to generate a race condition in the database in the same way that
    # <tt>validates_uniqueness_of</tt> can. You're encouraged to add a unique index in the database to deal
    # with this even more unlikely scenario.
    def has_secure_token(attribute = :token)
      # Load securerandom only when has_secure_token is used.
      define_method("regenerate_#{attribute}") { update! attribute => self.class.generate_unique_secure_token }
      before_create { self.send("#{attribute}=", self.class.generate_unique_secure_token) unless self.send("#{attribute}?")}
    end

    def generate_unique_secure_token
      SecureRandom.base58(24)
    end
  end
end

require 'securerandom'

module SecureRandom
  BASE58_ALPHABET = ('0'..'9').to_a  + ('A'..'Z').to_a + ('a'..'z').to_a - ['0', 'O', 'I', 'l']
  # SecureRandom.base58 generates a random base58 string.
  #
  # The argument _n_ specifies the length, of the random string to be generated.
  #
  # If _n_ is not specified or is nil, 16 is assumed. It may be larger in the future.
  #
  # The result may contain alphanumeric characters except 0, O, I and l
  #
  #   p SecureRandom.base58 #=> "4kUgL2pdQMSCQtjE"
  #   p SecureRandom.base58(24) #=> "77TMHrHJFvFDwodq8w7Ev2m7"
  #
  def self.base58(n = 16)
    SecureRandom.random_bytes(n).unpack("C*").map do |byte|
      idx = byte % 64
      idx = SecureRandom.random_number(58) if idx >= 58
      BASE58_ALPHABET[idx]
    end.join
  end
end
