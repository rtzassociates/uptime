module WindowsServersHelper
  def windows_clients_for server
    raw server.windows_clients.map { |c| c.name }.to_sentence
  end
end
