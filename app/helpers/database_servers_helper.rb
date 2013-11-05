module DatabaseServersHelper
  def databases_for(server)
    unless server.databases.empty?
      database_list = server.databases.order(:name).collect { |database| link_to(database.name, database, :class => "link-large") }.to_sentence
      raw "#{database_list}"
    end
  end
end
