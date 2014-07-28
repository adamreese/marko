require 'spec_helper'

describe "marko/campaigns" do
  let!(:client) { create_client }
  let(:campaign) { client.campaigns.all.first }

  it "should get a campaign by id" do
    expect(campaign.id).not_to be_nil

    fetched = client.campaigns.get(campaign.id)

    expect(fetched.name).not_to be_nil
  end
end
