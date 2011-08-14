require 'integreat'

Integreat "Testing that this works" do
  
  Test "Computer can calculate correctly" do
    
    Step "can do addition" do
      result = 3 + 5
      assert(8, result)
    end

    Step "can do substraction" do
      result = 3 - 5
      assert(-2, result)
    end
    
    Step "can do multiplications" do
      result = 3 * 5
      
      assert(100, result)
    end
  end

end