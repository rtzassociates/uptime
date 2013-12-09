module ApplicationServersHelper

  def list_for(resource)
    unless resource.empty?
      raw resource.order(:name).collect { |r| link_to(r.name, r) }.to_sentence
    end
  end

  def site_databases_for(server)
    unless server.site_databases.empty?
      raw server.site_databases.order(:name).collect { |database| link_to(database.name, database) }.to_sentence
    end
  end
  
  def site_database_servers_for(server)
    unless server.site_database_servers.empty?
      raw server.site_database_servers.order(:name).collect { |server| link_to(server.name, server) }.to_sentence
    end
  end
  
end
