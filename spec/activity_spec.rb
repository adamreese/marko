require 'spec_helper'

describe "marko/activity" do
  let!(:client) { create_client }
  let(:activities) { client.activities.all}

  it "should get activity types" do
    expect(activities).not_to be_empty
  end

  it "should format activity_attributes" do
    expect(activities.first.activity_attributes).not_to be_empty
  end
end
