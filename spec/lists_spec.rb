require 'spec_helper'

describe "marko/lists" do
  let!(:client) { create_client }
  let(:list) { client.lists.all.first }

  it "should get a list of lists" do
    expect(client.lists.all).not_to be_nil
  end

  it "should get a list by id" do
    expect(list.id).not_to be_nil

    fetched = client.lists.get(list.id)

    expect(fetched.name).not_to be_nil
  end
end
