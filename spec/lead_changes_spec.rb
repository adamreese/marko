require 'spec_helper'

describe "marko/lead_changes" do
  let!(:client) { create_client }
  let(:lead_change) { client.lead_changes.all.first }

  it "should get a lead change record" do
    expect(lead_change.id).not_to be_nil
  end
end
