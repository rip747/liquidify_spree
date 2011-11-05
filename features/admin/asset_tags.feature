Feature: Render valid asset tags in temolate
	Must have all liquid tags to fetch asset paths
	
	Background:
		Given I have the theme: "Default" set up

Scenario: Get stylesheet path in liquid markup
	Given asset named "test.css"
	When I render liquid template with "{{ 'test.css' | stylesheet_url }}"
	Then must get a "/themes/1/stylesheets/test.css"
	
Scenario: Get javascript path in liquid markup
	Given asset named "test.js"
	When I render liquid template with "{{ 'test.js' | javascript_url }}"
	Then must get a "/themes/1/javascripts/test.js"

Scenario: Get image path in liquid markup
	Given asset named "test.png"
	When I render liquid template with "{{ 'test.png' | theme_image_url }}"
	Then must get a "/themes/1/images/test.png"

