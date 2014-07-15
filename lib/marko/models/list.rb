class Marko::Client::List < Marko::Model
  identity :id

  attribute :name,             aliases: "name"
  attribute :description,      aliases: "description"
  attribute :program_name,     aliases: "programName"
  attribute :workspace_name,   aliases: "workspaceName"
  attribute :created_at,       aliases: "createdAt",     type: :datetime
  attribute :update_at,        aliases: "updatedAt",     type: :datetime

  def leads
    requires :identity

    path = "/list/#{self.identity}/leads.json"
    data = connection.get_leads(:path => path).body
    connection.leads.load(data["result"])
    connection.leads.merge_attributes(data)
  end
end
