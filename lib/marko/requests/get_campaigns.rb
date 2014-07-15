class Marko::Client
  class Real
    def get_campaigns(params={})
      request(
        :path   => "/campaigns.json",
        :params => params
      )
    end
  end # Real

  class Mock
    def get_campaigns(params={})
      response(
        :body     => {
          "requestId" => SecureRandom.hex,
          "sucess" => true,
          "result" => [
            {
              "id" => 60,
              "name" => "Cammpaign Name",
              "description" => "desc",
              "programName" => "ProgramName",
              "createdAt" => "2014-03-26T17:29:14+0000",
              "updatedAt" => "2014-03-26T18:04:10+0000"
            }
          ],
        },
        :status   => 200
      )
    end
  end # Mock
end # Marko::Client
