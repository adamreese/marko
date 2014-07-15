require 'spec_helper'

describe "marko/campaigns" do
  let!(:client) { create_client }

  it "should get a campaign by id" do
    campaign = client.campaigns.get(60)

    expect(campaign.name).not_to be_nil
  end
end
