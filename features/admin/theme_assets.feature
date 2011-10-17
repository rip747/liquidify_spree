Feature: Manage Theme Assets
	In order to manage theme assets
	As an administrator
	I want to add/edit/delete theme assets of my site

Background:
	Given I have the theme: "Default" set up

Scenario: Save stylesheet file
	Given a stylesheet file named "test.css"
	When I create new ThemeAsset item from this file
	Then file must have content_type "stylesheet"