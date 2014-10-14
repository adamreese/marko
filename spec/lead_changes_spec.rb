require 'spec_helper'

describe "marko/lead_changes" do
  let!(:client) { create_client }
  let(:lead_change) { client.lead_changes.all(fields: ['firstName','lastName', 'email']) }

  it "should get a lead change record" do
    expect(lead_change.first.id).not_to be_nil
  end

  it "should format activity attributes to a hash" do
    expect(lead_change.first.activity_attributes["Reason"]).to eq("Web service API")
  end

  it "should format fields to a hash" do
    expect(lead_change.first.fields["id"]).to eq("48")
  end
end
