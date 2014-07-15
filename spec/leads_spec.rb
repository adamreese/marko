require 'spec_helper'

describe "marko/leads" do
  let!(:client) { create_client }
  let!(:lead) { client.leads.create(email: "rspec-test@example.com", first_name: "rspec") }
  let!(:lead2) { client.leads.create(email: "rspec-test2@example.com", first_name: "rspec2") }

  it "should get leads" do
    expect(client.leads.all(email: "rspec-test@example.com").map(&:id)).to include(lead.identity)
  end

  it "should get a lead by id" do
    fetched = client.leads.get(lead.identity)

    expect(lead.email).to eq("rspec-test@example.com")
    expect(fetched).to eq(lead)
    expect(fetched.email).to eq("rspec-test@example.com")
  end
end
