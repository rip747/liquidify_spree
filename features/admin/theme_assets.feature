Feature: Manage Theme Assets
	In order to manage theme assets
	As an administrator
	I want to add/edit/delete theme assets of my site

Background:
	Given I have the theme: "Default" set up

Scenario: Save stylesheet file
	Given a files
	 | file     |
	 | test.css |
	 | test.js  |
	 | test.png |

	When I create new ThemeAssets item from this files
	Then files must eq with their content_types
	 | content_type |
	 | stylesheet   |
	 | javascript   |
	 | image        |
	
Scenario: Store planar text in file
	Given any planar text
	And Default theme must have no one any theme asset
	When I create a "test" file with "stylesheet" type
	Then I must have a file in default theme with name "test.css" and type "stylesheet"
	And source of this file must be not empty
	And content of this file must be as given planar text
