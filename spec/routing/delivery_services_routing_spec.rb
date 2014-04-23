require "spec_helper"

describe DeliveryServicesController do
  describe "routing" do

    it "routes to #index" do
      get("/delivery_services").should route_to("delivery_services#index")
    end

    it "routes to #new" do
      get("/delivery_services/new").should route_to("delivery_services#new")
    end

    it "routes to #show" do
      get("/delivery_services/1").should route_to("delivery_services#show", :id => "1")
    end

    it "routes to #edit" do
      get("/delivery_services/1/edit").should route_to("delivery_services#edit", :id => "1")
    end

    it "routes to #create" do
      post("/delivery_services").should route_to("delivery_services#create")
    end

    it "routes to #update" do
      put("/delivery_services/1").should route_to("delivery_services#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/delivery_services/1").should route_to("delivery_services#destroy", :id => "1")
    end

  end
end
