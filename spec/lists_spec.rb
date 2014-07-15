require 'spec_helper'

describe "marko/lists" do
  let!(:client) { create_client }
  let(:list) { client.lists.get(60) }

  it "should get a list by id" do
    expect(list.name).not_to be_nil
  end

  it "should keep a page token" do
    expect(list.leads.next_page_token).not_to be_nil
  end
end
