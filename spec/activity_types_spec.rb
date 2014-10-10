require 'spec_helper'

describe "marko/activity_types" do
  let!(:client) { create_client }
  let(:activity_types) { client.activity_types.all}

  it "should get activity types" do
    expect(activity_types).not_to be_empty
  end

  it "should format activity_attributes" do
    expect(activity_types.first.activity_attributes).not_to be_empty
  end
end
