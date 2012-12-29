require 'pony'

if ENV[ 'SENDGRID_USERNAME' ]
  Pony.options = {
    :via         => :smtp,
    :via_options => {
      :address        => 'smtp.sendgrid.net',
      :port           => '587',
      :authentication => :plain,
      :user_name      => ENV[ 'SENDGRID_USERNAME' ],
      :password       => ENV[ 'SENDGRID_PASSWORD' ],
      :domain         => 'heroku.com'
    }
  }
else
  class MailDump
    def initialize( values )
      @settings = {}
    end
    
    attr_accessor :settings

    def deliver!( mail )
      puts mail.to_s
    end
  end
  Pony.options = { :via => MailDump }
end
