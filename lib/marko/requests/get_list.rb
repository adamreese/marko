class Marko::Client
  class Real
    def get_list(id)
      request(
        :path => "/lists/#{id}.json",
      )
    end
  end # Real

  class Mock
    def get_list(id)
      list = self.data[:lists][id]

      response(
        :body     => {
          "requestId" => SecureRandom.hex,
          "success"   => true,
          "result"    => [
            {
              "id" => 60,
              "name" => "List Name",
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
