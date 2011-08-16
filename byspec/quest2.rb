require 'integreat'
require 'curlser'

Integreat "x1" do
  
  Test "x2" do
        
    Step "x3" do
      @browser = Curlser.new "http://localhost:4567"
    end
    
    Step "x4" do
      
      25.times do
        @browser.get "/whoami"
      end
      
      bodies = @browser.responses.map(&:body)
      unique_bodies = bodies.uniq
      
      assert(1, unique_bodies.size)
    end
    
    
    Step "x5" do
      
      25.times do
        @browser.cookie_jar.delete!
        @browser.get "/whoami"
      end
      
      bodies = @browser.responses.map(&:body)
      unique_bodies = bodies.uniq
      
      assert(2, unique_bodies.size)
    end

  end


  
end