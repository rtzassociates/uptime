require "spec_helper"

describe ServerRolesController do
  describe "routing" do

    it "routes to #index" do
      get("/server_roles").should route_to("server_roles#index")
    end

    it "routes to #new" do
      get("/server_roles/new").should route_to("server_roles#new")
    end

    it "routes to #show" do
      get("/server_roles/1").should route_to("server_roles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/server_roles/1/edit").should route_to("server_roles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/server_roles").should route_to("server_roles#create")
    end

    it "routes to #update" do
      put("/server_roles/1").should route_to("server_roles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/server_roles/1").should route_to("server_roles#destroy", :id => "1")
    end

  end
end
