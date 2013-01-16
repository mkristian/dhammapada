require 'ixtlan/remote/sync'
class Updater < Ixtlan::Remote::Sync

  def initialize
    super CubaAPI[ :rest ]
    register( Ixtlan::UserManagement::User )
  end

end
