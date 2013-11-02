module DatabasesHelper
  def sites_for(database)
    unless database.sites.empty?
      site_list = database.sites.collect { |site| link_to(site.name, site, :class => "link-large") }.to_sentence
      raw "#{site_list}"
    end
  end
end
