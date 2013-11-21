module WindowsServersHelper
  def windows_clients_for(server)
    unless server.windows_clients.empty?
      client_list = server.windows_clients.order(:name).map { |client| client.name }.to_sentence
      raw "#{client_list}"
    end
  end
end