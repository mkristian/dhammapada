unless u = Ixtlan::UserManagement::User.get(1)
  u = Ixtlan::UserManagement::User.new(:name => "System", :login => "system", :updated_at => DateTime.new(1))
  u.id = 1
  u.save
  warn "[DataMapper]\t#{u}" if u.valid?
end
unless uu = Ixtlan::UserManagement::User.get(2)
  uu = Ixtlan::UserManagement::User.new(:name => "Root", :login => "root", :updated_at => DateTime.new(1))
  uu.id = 2
  uu.save
  warn "[DataMapper]\t#{uu}" if uu.valid?
end

c = Ixtlan::Configuration::Configuration.instance
if c.new?
  c.modified_by = u
  c.save
  warn "[DataMapper]\t#{c}" if c.valid?
end
