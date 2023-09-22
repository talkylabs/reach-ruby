describe Reach do
  after(:each) do
    Reach.instance_variable_set('@configuration', nil)
  end

  it 'should set the configuration with a config block' do
    Reach.configure do |config|
      config.username = 'someSid'
      config.auth_token = 'someToken'
      config.http_client = 'someClient'
    end

    expect(Reach.username).to eq('someSid')
    expect(Reach.auth_token).to eq('someToken')
    expect(Reach.http_client).to eq('someClient')
  end
end
