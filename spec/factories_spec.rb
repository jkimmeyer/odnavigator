require 'rails_helper'

# Meta-test that fails immediately if a factory is not valid
# http://robots.thoughtbot.com/testing-your-factories-first
# https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#linting-factories

RSpec.describe 'Factories' do
  it 'can be created' do
    FactoryBot.lint
  end
end

FactoryBot.factories.map(&:name).each do |factory_name|
  RSpec.describe "The #{factory_name} factory" do
    it 'can be created multiple times' do
      expect { create_list(factory_name, 2) }.not_to raise_error
    end
  end
end
