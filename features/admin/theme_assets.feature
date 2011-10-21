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
