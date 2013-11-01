require "spec_helper"

describe DatabaseServersController do
  describe "routing" do

    it "routes to #index" do
      get("/database_servers").should route_to("database_servers#index")
    end

    it "routes to #new" do
      get("/database_servers/new").should route_to("database_servers#new")
    end

    it "routes to #show" do
      get("/database_servers/1").should route_to("database_servers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/database_servers/1/edit").should route_to("database_servers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/database_servers").should route_to("database_servers#create")
    end

    it "routes to #update" do
      put("/database_servers/1").should route_to("database_servers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/database_servers/1").should route_to("database_servers#destroy", :id => "1")
    end

  end
end
