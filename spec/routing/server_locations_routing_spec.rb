require "spec_helper"

describe ServerLocationsController do
  describe "routing" do

    it "routes to #index" do
      get("/server_locations").should route_to("server_locations#index")
    end

    it "routes to #new" do
      get("/server_locations/new").should route_to("server_locations#new")
    end

    it "routes to #show" do
      get("/server_locations/1").should route_to("server_locations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/server_locations/1/edit").should route_to("server_locations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/server_locations").should route_to("server_locations#create")
    end

    it "routes to #update" do
      put("/server_locations/1").should route_to("server_locations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/server_locations/1").should route_to("server_locations#destroy", :id => "1")
    end

  end
end
