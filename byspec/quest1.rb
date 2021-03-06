require 'integreat'
require 'curlser'

Integreat "x1" do
  
  Test "x2" do
    
    Step "x3" do
      browser = Curlser.new "http://localhost:4567"
      browser.get "/"
      assert("401", browser.responses.last.status)
    end
    
    Step "x4" do
      @browser = Curlser.new "http://joe:d34db33f@localhost:4567"      
    end
    
    Step "x5" do
      @browser.get "/"
      assert(true, @browser.responses.last.body.include?('/messages" method="POST"'))
    end
    
    Step "x6" do
      3.times do
        @browser.post "/messages", { "message" => "Hallo, Berlin" }
      end
      assert("302", @browser.responses.last.status)      
    end
      
    Step "x7" do
      @browser.post "/messages", { "message" => "Hello, Helsinki" }
      assert("302", @browser.responses.last.status)
    end
    
    Step "x8" do
      @browser.get "/"
      assert(true, @browser.responses.last.body.include?("Hello, Helsinki"))
    end
    
  end


  
end