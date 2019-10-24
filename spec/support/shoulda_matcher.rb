Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :sprec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end