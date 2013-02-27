Given /^I send and accept (XML|JSON)$/ do |type|
  begin
    header 'Accept', "application/#{type.downcase}"
    header 'Content-Type', "application/#{type.downcase}"

  rescue
    puts "set headers failed"
  end
end

When /^I send a (GET|POST|PUT|DELETE) request (?:for|to) "([^"]*)" with the following:?$/ do |request_type, path, input|
  api_request(request_type, path, input)
end

When /^I send a (GET|POST|PUT|DELETE) request (?:for|to) "([^"]*)"$/ do |request_type, path|
  api_request(request_type, path, nil)
end

def api_request(request_type, path, input)
  request_opts = {method: request_type.downcase.to_sym}
  if @user.authentication_token.present?
    separator = (path.include?"?")?"&":"?"
    auth_token = @user.authentication_token
    path = path + "#{separator}auth_token=#{auth_token}"
    puts path
  end

  unless input.nil?
    if input.class == Cucumber::Ast::Table
      request_opts[:params] = input.rows_hash
    else
      request_opts[:params] = input
    end
  end

  request path, request_opts
end

Then /^I log in as "([^"]*)"$/ do |email|
  @auth_token = User.where(email: email).authentication_token
  puts @auth_token
end

Then /^show me the response$/ do
  if last_response.headers['Content-Type'] =~ /json/
    json_response = JSON.parse(last_response.body)
    puts JSON.pretty_generate(json_response)
  elsif last_response.headers['Content-Type'] =~ /xml/
    puts Nokogiri::XML(last_response.body)
  else
    puts last_response.headers
    puts last_response.body
  end
end

Then /^the response status should be "([^"]*)"$/ do |status|
  if self.respond_to? :should
    last_response.status.should == status.to_i
  else
    assert_equal status.to_i, last_response.status
  end
end

Then /^the JSON response should (not)?\s?have "([^"]*)" with the text "([^"]*)"$/ do |negative, json_path, text|
  json = JSON.parse(last_response.body)

  if self.respond_to?(:should)
    if negative.present?
      assert json[json_path].to_s != text
    else
      assert json[json_path].to_s == text
    end
  else
    if negative.present?
      assert json[json_path].to_s != text
    else
      assert json[json_path].to_s == text
    end
  end
end

Then /^the JSON response should have an array of "([^"]*)" records$/ do |length|
  json = JSON.parse(last_response.body)
  assert json.size == length.to_i
end

Then 'the JSON response should be:' do |json|
  expected = JSON.parse(json)
  actual = JSON.parse(last_response.body)

  if self.respond_to?(:should)
    actual.should == expected
  else
    assert_equal actual, response
  end
end