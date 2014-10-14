class Marko::Client
  class Real
    def get_activity_types
      request(
        :path => "/activities/types.json",
      ).tap { |r| r.body['result'].map { |result| Marko.rename_attributes(result) } }
    end
  end # Real

  class Mock
    def get_activity_types
      response(
        :body => {
          "requestId" => SecureRandom.hex,
          "success"   => true,
          "result"    => [
            {
              "id"          => "60",
              "name"        => "Visit Webpage",
              "description" => "User visits web page",
              "primaryAttribute" => {
                "name"     => "Webpage ID",
                "dataType" => "integer"
              },
              "attributes" => [
                {
                  "name" => "Client IP Address",
                  "dataType" => "string"
                },
                {
                  "name" => "Query Parameters",
                  "dataType" => "string"
                },
                {
                  "name" => "Referrer URL",
                  "dataType" => "string"
                },
                {
                  "name" => "Search Engine",
                  "dataType" => "string"
                },
                {
                  "name" => "Search Query",
                  "dataType" => "string"
                },
                {
                  "name" => "User Agent",
                  "dataType" => "string"
                },
                {
                  "name" => "Webpage URL",
                  "dataType" => "string"
                }
              ]
            }
          ]
        },
        :status   => 200
      )
    end
  end # Mock
end # Marko::Client
