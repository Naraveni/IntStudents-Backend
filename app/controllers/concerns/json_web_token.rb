require 'jwt'
module JsonWebToken
  extend ActiveSupport::Concern
  SECRET_KEY  = RAILS.application.secret_key_base
  def jwt_encode(payload, exp = 1.day.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload,secret_key_base)
  end

  def jwt_decode(token)
    HashWithIndifferentAccess.new decode
  end

end