require "spec_helper"

describe SiteEnvironmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/site_environments").should route_to("site_environments#index")
    end

    it "routes to #new" do
      get("/site_environments/new").should route_to("site_environments#new")
    end

    it "routes to #show" do
      get("/site_environments/1").should route_to("site_environments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/site_environments/1/edit").should route_to("site_environments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/site_environments").should route_to("site_environments#create")
    end

    it "routes to #update" do
      put("/site_environments/1").should route_to("site_environments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/site_environments/1").should route_to("site_environments#destroy", :id => "1")
    end

  end
end
