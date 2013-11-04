module ApplicationServersHelper
  def site_databases_for(server)
    unless server.site_databases.empty?
      database_list = server.site_databases.collect { |database| link_to(database.name, database, :class => "link-large") }.to_sentence
      raw "#{database_list}"
    end
  end
  
  def site_database_servers_for(server)
    unless server.site_database_servers.empty?
      server_list = server.site_database_servers.collect { |server| link_to(server.name, server, :class => "link-large") }.to_sentence
      raw "#{server_list}"
    end
  end
end
