Feature: Links collections set of site
  I want have any link for site in liquid collections

Scenario: Having pages collections
  Given abstract link collection
  When I send "collections" method to abstract collection
  Then I mush have many collections
  
Scenario: Retrive links of static pages
  Given site with any sets of page
  When retrive links collections
  Then I must have many links of pages


