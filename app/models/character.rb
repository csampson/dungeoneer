class Character < ActiveRecord::Base
  include SecureToken
  has_secure_token :read_only_slug
end
