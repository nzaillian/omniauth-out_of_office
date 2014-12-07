require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class OutOfOffice < OmniAuth::Strategies::OAuth2
      option :name, 'out_of_office'

      option :client_options, {
        :site => "https://outofoffice.travel",
        :authorize_url => "/oauth/authorize"
      }

      uid { raw_info["id"] }

      info do
        {
          :email => raw_info["email"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/users/me.json').parsed
      end
    end
  end
end