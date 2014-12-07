# OmniAuth Provider for OutOfOffice.travel

This gem implements a drop-in OmniAuth provider to authenticate users for API requests against OutOfOffice.travel. 
Currently the oauth API is closed to our partners and you cannot obtain credentials through any self-service form. 
If you are a partner and would like an Oauth credential set please write to contact@outofoffice.travel.

### Step-by-step Usage

Add gems to your Gemfile

    gem 'omniauth'

    gem 'omniauth-out_of_office', git: 'git@github.com:nzaillian/omniauth-out_of_office.git'

Add your outofoffice.travel Oauth credentials in the OmniAuth initializer (if you do not have credentials, please write to contact@outofoffice.travel).

    # config/initializers/omniauth.rb

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :out_of_office, 'CLIENT_ID', 'CLIENT_SECRET'
    end    

The post-authentication callback is '/auth/out_of_office/callback' so create a route:

    # config/routes.rb

    get '/auth/out_of_office/callback' => 'users_controller#ooo_auth_callback'

Now when you point your user (through an on-site link or similar) to...

    http://your-web-site.com/auth/out_of_office

...OmniAuth will bounce the user to a login page at https://outofoffice.travel. When they have successfully authenticated on outofoffice.travel, they will be bounced to your callback action with some extra metadata passed along:

    class UsersController < ApplicationController
      def ooo_auth_callback
        auth =  request.env["omniauth.auth"]

        # your post-authentication logic might look something like this...
        @user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
        sign_in @user # e.g. if using devise

        # note, there is also be a nested hash within the auth hash (with key 'info') 
        # that contains the email account with which the user's outofoffice.travel account is associated

        Rails.logger.info ">>> user's outofoffice.travel email: #{auth['info']['email']}"

        redirect_to root_path, flash: {notice: 'Signed in through outofoffice.travel'}
      end
    end

