Feature: Manage themes
  In order to [goal]
  [stakeholder]
  wants [behaviour]

  Scenario: Delete theme
    Given the following themes:
      |name|description|
      |name 1|description 1|
      |name 2|description 2|
      |name 3|description 3|
      |name 4|description 4|
    When I delete the 3rd theme
    Then I should have the following themes:
      |name|description|
      |name 1|description 1|
      |name 2|description 2|
      |name 4|description 4|
