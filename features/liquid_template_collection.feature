Feature: Liquidify templates collection
  In order to register templates
  As a templates register collection
  I want has Singleton class

	Scenario: Implement only one class of singleton
	  Given singleton named LiquidifyTemplatesCollection
	  When I add any template to collection
	  Then I must see one instance of collection with hash of templates
	
	Scenario: Extend Array class with LiquidifyExtender mixin
	  Given class with included LiquidifyExtender module
	  When register any actions with templates for this class
		And dublicate call registration action for one class
	  Then liauid collection must have this hash
		And each class in collection must have only one last template to any action
	
	
	
	
	
	

  
