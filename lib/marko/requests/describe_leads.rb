class Marko::Client
  class Real
    def describe_leads(params={})
      path = "/leads/describe.json"

      request(
        :path   => path,
        :params => params,
      )
    end
  end # Real

  class Mock
    def describe_leads(params={})

      response(
        :body     => {
          "requestId" => SecureRandom.hex,
          "sucess" => true,
          "result" => "",
          "nextPageToken" => SecureRandom.hex,
        },
        :status   => 200
      )
    end
  end # Mock
end # Marko::Client
