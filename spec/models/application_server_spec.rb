require 'spec_helper'

describe ApplicationServer do
  it { should have_many(:site_application_servers) }
  it { should have_many(:sites) }

  describe "ApplicationServer#site_urls" do
    server = FactoryGirl.create(:application_server)
  end
end
