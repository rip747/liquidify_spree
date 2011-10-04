Feature: Snippets
  In order to snippets saving in database
  As a role site administrator
  I want feature

	Scenario: Check whether the pattern asset liquid
	  Given snippet with filename and template:
	 | name             | raw_item_template             |
	 | layout.liquid    | this is a {{name}}            |
	 | layout.css       | #ident: {color: #fff;}        |
	 | layout.js.liquid | console.debug({{test_value}}) |
	  Then each snippet must eq this table
	 | name             | value |
	 | layout.liquid    | true  |
	 | layout.css       | false |
	 | layout.js.liquid | true  |
