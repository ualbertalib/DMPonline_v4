require "yaml"

module After 

  def teardown 

    after(:all) do
    
      @driver.quit
      expect(@verification_errors).to be_empty

    end
  end

end
