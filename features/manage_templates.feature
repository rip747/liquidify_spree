Feature: Manage templates
  In order to [goal]
  [stakeholder]
  wants [behaviour]

  Scenario: store templates in database
    Given the following templates:
      | name           | description              | raw_item_template         |
      | index.liquid   | This is a index page     | page {{ name }}-{{index}} |
      | 404.liquid     | is 404 error page        | page {{ name }}-{{index}} |
      | product.liquid | page with product detail | page {{ name }}-{{index}} |
      | cart.liquid    | cart page                | page {{ name }}-{{index}} |
		And values hash:
		 | name           | index | result                |
		 | index.liquid   | 1     | page index.liquid-1   |
		 | 404.liquid     | 2     | page 404.liquid-2     |
		 | product.liquid | 3     | page product.liquid-3 |
		 | cart.liquid    | 4     | page cart.liquid-4    |
		When I render templates
		Then All templates must be liquidify
		And I must have template eq result
