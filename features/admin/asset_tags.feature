Feature: Render valid asset tags in temolate
	Must have all liquid tags to fetch asset paths
	
	Background:
		Given I have the theme: "Default" set up

Scenario: Get stylesheet path in liquid markup
	Given stylesheet asset named "test.css"
	When I render liquid template with "{% theme_asset_url stylesheets/test.css %}"
	Then must get a "/themes/1/stylesheets/test.css"
	
	When I render liquid template with "{{ stylesheets/test.css | stylesheet }}"
	Then must get a "/themes/1/stylesheets/test.css"

"