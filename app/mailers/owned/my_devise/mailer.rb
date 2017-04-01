module Owned
  class MyDevise::Mailer < Devise::Mailer
    helper :application # gives access to all helpers defined within `application_helper`.
    include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

    def confirmation_instructions(record, token, opts={})
      @subdomain = record.subdomain
      super
    end
  end
end
