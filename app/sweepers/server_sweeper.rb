class ServerSweeper < ActionController::Caching::Sweeper
  observe ApplicationServer
  observe DatabaseServer
  observe Network
  
  def sweep(server)
    expire_page servers_path
    FileUtils.rm_rf "#{page_cache_directory}/servers/page"
  end
  
  alias_method :after_update, :sweep 
  alias_method :after_create, :sweep 
  alias_method :after_destroy, :sweep 
end