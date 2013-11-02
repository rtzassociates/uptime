module DatabaseServersHelper
  def databases_for(server)
    unless server.databases.empty?
      database_list = server.databases.collect { |database| link_to(database.name, database, :class => "link-large") }.to_sentence
      raw "#{database_list}"
    end
  end
end
