class Marko::Client
  class Real
    def get_activities(params={})

      params.fetch(:next_page_token, get_paging_token)

      request(
        :path => "/activities.json",
        :params => params
      )
    end
  end # Real

  class Mock
    def get_activities
      response(
        :body => {
          "requestId" => SecureRandom.hex,
          "success"   => "true",
          "result"    => [
            {
              "id" => "2",
              "leadId" => '6',
              "activityDate" => "2013-09-26T06:56:35+0000",
              "activityTypeId" => "12",
              "primaryAttributeValueId" => "6",
              "primaryAttributeValue" => "Owyliphys Iledil",
              "attributes" => [
                {
                  "name" => "Source Type",
                  "value" => "Web page visit"
                },
                {
                  "name" => "Source Info",
                  "value" => "http://search.yahoo.com/search?p=train+cappuccino+army"
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
