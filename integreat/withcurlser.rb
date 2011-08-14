require 'integreat'
require 'curlser'

Integreat "Remote testing" do
  
  Test "We get greeted" do
    
    Step "Initialize a browser" do
      @browser = Curlser.new "http://localhost:4567"
    end

    Step "Request a greeting from a web app" do
      @browser.get "/hello/integreator"
      
      assert("200", @browser.responses.last.status)
    end
    
    Step "See that the greeting is correct" do
      assert("Hello, integreator", @browser.responses.last.body)
    end

  end


  Test "Also other paths work" do

    Step "The root is recognized as a path" do
      @browser.get "/"
      assert("200", @browser.responses.last.status)      
    end
    
    Step "The root greets somebody (Hello, somebody)" do
      assert("Hello, somebody", @browser.responses.last.body)
    end

    Step "Name is a parameter in the path" do
      @browser.get "/hello/unknown"
      assert("200", @browser.responses.last.status)      
    end
    
    Step "Unknown is greeted" do
      assert("Hello, unknown", @browser.responses.last.body)
    end
    
    
    Step "Parameters are recognized" do
      @browser.get "/hello/unknown?with=secrets"
      assert("200", @browser.responses.last.status)      
    end
    
    Step "The name and parameters are combined" do
      assert("Hello, unknown with secrets", @browser.responses.last.body)
    end

  end
  
end