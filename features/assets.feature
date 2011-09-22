Feature: Assets
  In order to assets saving in database
  As a role site administrator
  I want feature

	Scenario: Check whether the pattern asset liquid
	  Given assets with filename and template:
	 | name             | raw_item_template             |
	 | layout.liquid    | this is a {{name}}            |
	 | layout.css       | #ident: {color: #fff;}        |
	 | layout.js.liquid | console.debug({{test_value}}) |
	  Then each asset must eq this table
	 | name             | liquidefy |
	 | layout.liquid    | true      |
	 | layout.css       | false     |
	 | layout.js.liquid | true      |
	
	
	
	
