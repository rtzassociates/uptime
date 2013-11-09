require "spec_helper"

describe ServerTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/server_types").should route_to("server_types#index")
    end

    it "routes to #new" do
      get("/server_types/new").should route_to("server_types#new")
    end

    it "routes to #show" do
      get("/server_types/1").should route_to("server_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/server_types/1/edit").should route_to("server_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/server_types").should route_to("server_types#create")
    end

    it "routes to #update" do
      put("/server_types/1").should route_to("server_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/server_types/1").should route_to("server_types#destroy", :id => "1")
    end

  end
end
