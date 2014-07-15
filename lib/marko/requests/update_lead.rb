class Marko::Client
  class Real
    def update_lead(identity, params={})
      request(
        :method => :post,
        :path   => "leads.json",
        :body   => {
          "action" => "updateOnly",
          "lookupField" => "id",
          "input" => [ params ],
        },
      )
    end
  end # Real

  class Mock
    def update_lead(identity, params={})

      if resource = self.data[:leads][identity]
        resource.merge!(params)

        response(
          :body    => {
            "requestId" => SecureRandom.hex,
            "result" => [ "id" => identity ],
            "sucess" => true,
          },
          :status  => 201
        )
      else
        response(status: 404)
      end
    end
  end # Mock
end # Marko::Client
