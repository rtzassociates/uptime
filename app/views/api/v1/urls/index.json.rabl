collection @urls
attributes :name, :check_string

child :site do
  attributes :name
  child :site_environment do
    attributes :name
  end
end