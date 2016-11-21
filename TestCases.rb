# TestCases.rb
=begin
This ruby code performs both a positive and a negative test case on
a basic web form. The positive case supplies all required fields 
while the negative test case does not. The positive test case performs
a successful submit while the negative one triggers validation messages.
=end


# These test cases utilize the test unit and selenium webdriver libraries.
require "test/unit"
require "selenium-webdriver"

class TestCases < Test::Unit::TestCase

	# Code to be run before each test case.
	def setup
		@driver = Selenium::WebDriver.for(:chrome)
		@driver.get("https://docs.google.com/forms/d/e/1FAIpQLSeT6MPuoZm8Ks3TUw9j3lTKeUlwvcVseFeear6OF4ey24Q40g/viewform")
	end
	
	# Code to be run after each test case.
	def teardown
		@driver.quit
	end

	# This is the positive test case. Values are supplied for the required fields
	# and the submit button is invoked. The code then asserts whether the correct
	# page is loaded after the submit.
	def testPositive

		textFieldInput = @driver.find_element(:name,"entry.1041466219").send_keys("John Smith")

		checkBox = @driver.find_element(:id,"group_310473641_1").click()

		submitButton = @driver.find_element(:id,"ss-submit")
		submitButton.submit()

		pageTitle = @driver.title
		
		puts()
		puts("Page title is "+pageTitle)

		assert_equal("Thanks!",pageTitle)

	end
	
	# This is the negative test case. It does not include values for the required 
	# fields. This will cause validation to fail. After invoking the submit button
	# it should remain on the same page. The test case asserts this. If the negative
	# case behaves as expected the assertion will be true.
	def testNegative
	
		submitButton = @driver.find_element(:id,"ss-submit")
		submitButton.submit()
	
		pageTitle = @driver.title
		
		puts()
		puts("Page title is "+pageTitle)
		
		assert_equal("Basic Web Forms",pageTitle)
	
	end

end