require 'integreat'
require 'curlser'

Integreat "Key-Value Store" do
  
  Test "Basic operations with keys" do
    
    Step "Setup a client for localhost, port 4567" do
      @client = Curlser.new "http://localhost:4567"
      @client.delete_all_responses!
    end

    Step "Ensure clean database by DELETE /keys/somekey" do
      @client.delete "/keys/somekey"
    
      assert(true, ["200", "404"].include?(@client.responses.last.status))
    end
    
    Step "Verify that /keys/somekey is not found anymore" do
      @client.get "/keys/somekey"
    
      assert("404", @client.responses.last.status)      
    end
    
    Step "Setting a PUT /keys/somekey with value 'somevalue'" do
      @client.put "/keys/somekey", { "value" => "somevalue" }
      
      assert("200", @client.responses.last.status)
    end

    Step "Verify that /keys/somekey is set" do
      @client.get "/keys/somekey"
    
      assert("200", @client.responses.last.status)      
      assert("somevalue", @client.responses.last.body) 
    end
    
    Step "DELETE /keys/somekey deletes the key" do
      @client.delete "/keys/somekey"
      assert("200", @client.responses.last.status)      
    end
    
    Step "Now /keys/somekey should be gone" do
      @client.get "/keys/somekey"
      assert("404", @client.responses.last.status)
    end
  
  end
  
end



Integreat "Integers" do

  Test "Incrementing and decrementing" do
    
    Step "Ensure that key is empty by DELETE /keys/someinteger" do
      @client.delete "/keys/somekey"
      
      assert(true, ["200", "404"].include?(@client.responses.last.status))
    end
    
    Step "When incrementing two times with POST /keys/somekey/increment" do
      @client.post "/keys/somekey/increment"
      @client.post "/keys/somekey/increment"

      assert("200", @client.responses.last.status)
    end
    
    Step "Then GET /keys/somekey is '2'" do
      @client.get "/keys/somekey" 

      assert("2", @client.responses.last.body)
    end
    
    Step "When decrementing two times with POST /keys/somekey/decrement" do
      @client.post "/keys/somekey/decrement"
      @client.post "/keys/somekey/decrement"

      assert("200", @client.responses.last.status)
    end
    
    Step "Then GET /keys/somekey is '0'" do
      @client.get "/keys/somekey"

      assert("0", @client.responses.last.body)
    end
      
  end
  
end
