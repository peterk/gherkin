require 'stringio'
require 'gherkin/formatter/json_formatter'

# Monkey patching so that Hash.to_json has a predictable result.
class Hash
  alias orig_keys keys
  def keys
    orig_keys.sort
  end
end

Given /^a JSON formatter$/ do
  @io = StringIO.new
  @listener = Gherkin::Formatter::JSONFormatter.new(@io)
end

Then /^the outputted JSON should be:$/ do |expected_json|
  require 'json'
  expected = JSON.pretty_generate(JSON.parse(expected_json))
  actual   = JSON.pretty_generate(JSON.parse(@io.string))
  expected.should == actual
end


