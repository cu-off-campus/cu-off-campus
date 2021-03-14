Feature: Listing and filtering apartment listing

  As a Columbia student looking for off-campus housing
  I want to check out the apartment listings with some conditions
  So that I can determine which apartment fits the most

  Background: apartment data have been added to database

    Given the following apartment data exist
      | name       | price | rating | image                          | description  | address         |
      | Apartment1 | 1500  | 87     | https://some.image.com/ap1.jpg | Apartment 1. | 1 Apple St.     |
      | Apartment2 | 2000  | 96     |                                | Apartment 2. | 2 Apple St.     |
      | Apartment3 | 2500  | 92     |                                | Apartment 3! | 3 Banana St.    |
      | Apartment4 | 3000  | 97     | https://some.image.com/ap4.jpg | Apartment 4. | 4 Canal St.     |
      | Apartment5 | 3500  | 91     |                                | Apartment 5. | 5 Lafayette St. |

    And I am on the listing page
    Then 5 seed apartments should exist

  Scenario: Sort apartment by price
    When I select "Price" from "sort_select_box"
    And  I click "Filter"
    Then the order is as follows
      | Apartment5 |
      | Apartment4 |
      | Apartment3 |
      | Apartment2 |
      | Apartment1 |
    When I click "Home"
    Then the order is as follows
      | Apartment5 |
      | Apartment4 |
      | Apartment3 |
      | Apartment2 |
      | Apartment1 |

  Scenario: Sort apartment by rating
    When I click "Clear Filters"
    And  I select "Rating" from "sort_select_box"
    And  I click "Filter"
    Then the order is as follows
      | Apartment4 |
      | Apartment2 |
      | Apartment3 |
      | Apartment5 |
      | Apartment1 |

  Scenario: Filter apartment by price range
    When I click "Clear Filters"
    And  I select "1500~1999" from "price_select_box"
    And  I click "Filter"
    Then I should see "Apartment1"
    And  I should not see "Apartment2"

  Scenario: Search apartments
    When I click "Clear Filters"
    And  I fill in "search_input" with "Apple"
    And  I click "Filter"
    Then I should see "Apartment1"
    And  I should see "Apartment2"
    And  I should not see "Apartment3"
    When I fill in "search_input" with "Apartment5"
    And  I click "Filter"
    Then I should see "Apartment5"
    And  I should not see "Apartment2"

  Scenario: Unable to find any search results (the sad path)
    When I click "Clear Filters"
    And  I fill in "search_input" with "No such apartment"
    And  I click "Filter"
    Then I should see "No apartment found with the filters"
