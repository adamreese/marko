class Marko::Client
  class Real
    def create_lead(params={})
      request(
        :method => :post,
        :path   => "leads.json",
        :body   => {
          "action"      => "createOnly",
          "lookupField" => "email",
          "input"       => [ params ],
        },
      )
    end
  end # Real

  class Mock
    def create_lead(params={})
      identity = self.marketo_id

      resource = params.dup.merge(
        "id"  => identity
      )

      self.data[:leads][identity] = resource

      response(
        :body => {
          "requestId" => SecureRandom.hex,
          "success"   => true,
          "result"    => [ resource ],
        },
        :status  => 201
      )
    end
  end # Mock
end # Marko::Client
