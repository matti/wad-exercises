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




Integreat "List" do

           
    Test "Adding to list" do

      Step "Making sure that shopping list is empty by DELETE /keys/shoppinglist" do
        @client.delete "/keys/shoppinglist"
        assert(true, ["200", "404"].include?(@client.responses.last.status))
      end
            
      Step "Adding 'apples' to the list with POST /lists/shoppinglist?value=apples" do
        @client.post "/lists/shoppinglist", { "value" => "apples" }
        assert("200", @client.responses.last.status)
      end

      Step "Adding 'oranges' to the list" do
        @client.post "/lists/shoppinglist", { "value" => "oranges" }
        assert("200", @client.responses.last.status)
      end

      Step "Adding 'bananas' to the list" do
        @client.post "/lists/shoppinglist", { "value" => "bananas" }
        assert("200", @client.responses.last.status)
      end

      Step "Adding 'coconuts' to the list" do
        @client.post "/lists/shoppinglist", { "value" => "coconuts" }
        assert("200", @client.responses.last.status)
      end

    end

  

    
     
    
    Test "Removing from the list" do

      Step "Popping the last item with DELETE /lists/shoppinglist/pop should give 'coconuts' from the list" do
        @client.delete "/lists/shoppinglist/pop"

        assert("coconuts", @client.responses.last.body)
      end

      Step "Then, last the next item should be 'bananas'" do
        @client.delete "/lists/shoppinglist/pop"

        assert("bananas", @client.responses.last.body)
      end

      Step "Remember to buy 'oranges' also" do
        @client.delete "/lists/shoppinglist/pop"

        assert("oranges", @client.responses.last.body)
      end

      Step "And lastly 'apples'" do
        @client.delete "/lists/shoppinglist/pop"

        assert("apples", @client.responses.last.body)
      end

      Step "Now the list is empty (DELETE /lists/shoppinglist/pop returns '')" do
        @client.delete "/lists/shoppinglist/pop"
        
        assert("", @client.responses.last.body)        
      end
      
    end
    



    Test "List knows it's length" do
      
      Step "Making sure that the list does not contain old values by DELETE /keys/shoppinglist" do
        @client.delete "/keys/shoppinglist"
        assert(true, ["404", "200"].include?(@client.responses.last.status))
      end
      
      Step "Then we add 2 items to the list with POST /lists/shoppinglist?value=titanic and POST /lists/shoppinglist?value=sputnik" do
        @client.post "/lists/shoppinglist", { "value" => "titanic" }
        @client.post "/lists/shoppinglist", { "value" => "sputnik" }        
        
        assert("200", @client.responses.last.status)
      end
      
      Step "Now the list length is '2' when GET /lists/shoppinglist/length" do
        @client.get "/lists/shoppinglist/length"
        
        assert("2", @client.responses.last.body)
      end

      Step "When we delete the whole list with DELETE /keys/shoppinglist (not /lists, but /keys that is already implemented)" do
        @client.delete "/keys/shoppinglist"
        
        assert("200", @client.responses.last.status)
      end
      
      Step "Then the length is '0' when GET /lists/shoppinglist/length" do
        @client.get "/lists/shoppinglist/length"
        
        assert("0", @client.responses.last.body)
      end
    end


    Test "Some random testing" do
      
      Step "Add 10 items to the list" do
        10.times do |i|
          @client.post "/lists/shoppinglist", { "value" => i }
        end
      end

      Step "The list length is '10'" do
        @client.get "/lists/shoppinglist/length"
        
        assert("10", @client.responses.last.body)
      end
      
      Step "Pop 9 times" do
        9.times do
          @client.delete "/lists/shoppinglist/pop"
        end
        
        assert("200", @client.responses.last.status)
      end
      
      Step "The list length is 1" do
        @client.get "/lists/shoppinglist/length"
        
        assert("1", @client.responses.last.body)        
      end

      Step "Pop one more time" do
        @client.delete "/lists/shoppinglist/pop"        
      end
      
      Step "The list has emptied" do
        @client.get "/lists/shoppinglist/length"
        
        assert("0", @client.responses.last.body)                
      end
      
    end
    

end