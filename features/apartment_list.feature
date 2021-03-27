Feature: Listing and filtering apartment listing

  As a Columbia student looking for off-campus housing
  I want to check out the apartment listings with some conditions
  So that I can determine which apartment fits the most

  Background: apartment, user, comments data have been added to database

    Given the following apartment data exist
      | name       | price | image                          | description  | address         |
      | Apartment1 | 1500  | https://some.image.com/ap1.jpg | Apartment 1. | 1 Apple St.     |
      | Apartment2 | 2000  |                                | Apartment 2. | 2 Apple St.     |
      | Apartment3 | 2500  |                                | Apartment 3! | 3 Banana St.    |
      | Apartment4 | 3000  | https://some.image.com/ap4.jpg | Apartment 4. | 4 Canal St.     |
      | Apartment5 | 3500  |                                | Apartment 5. | 5 Lafayette St. |

    And the following users exist
      | username | password |
      | user1    | test1    |
      | user2    | test2    |
      | user3    | test3    |
      | user4    | test4    |
      | user5    | test5    |

    And the following comments exist
      | apartment_id | user_id | rating | comment   |
      | 1            | 1       | 80     | Good      |
      | 2            | 2       | 75     | OK        |
      | 3            | 3       | 85     | Great     |
      | 4            | 4       | 68     | Not good  |
      | 5            | 5       | 99     | Very good |

    Then 5 seed apartments should exist
    And  5 seed users should exist
    And  5 seed comments should exist

  Scenario: Sort apartment by price and clearing filter
    When I am on the listing page
    And  I select "Price" from "sort_select_box"
    And  I click "Filter"
    Then the apartment order is as follows
      | Apartment5 |
      | Apartment4 |
      | Apartment3 |
      | Apartment2 |
      | Apartment1 |
    When I click "Home"
    Then the apartment order is as follows
      | Apartment5 |
      | Apartment4 |
      | Apartment3 |
      | Apartment2 |
      | Apartment1 |
    When I click "Clear Filters"
    Then the apartment order is as follows
      | Apartment1 |
      | Apartment2 |
      | Apartment3 |
      | Apartment4 |
      | Apartment5 |

  Scenario: Sort apartment by rating
    When I am on the listing page
    And  I click "clear_filter_submit"
    And  I select "Rating" from "sort_select_box"
    And  I click "Filter"
    Then the apartment order is as follows
      | Apartment5 |
      | Apartment3 |
      | Apartment1 |
      | Apartment2 |
      | Apartment4 |

  Scenario: Filter apartment by price range
    When I am on the listing page
    And  I select "1500~1999" from "price_select_box"
    And  I click "Filter"
    Then I should see "Apartment1"
    And  I should not see "Apartment2"

  Scenario: Search apartments
    When I am on the listing page
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
    When I am on the listing page
    And  I fill in "search_input" with "No such apartment"
    And  I click "Filter"
    Then I should see "No apartment found with the filters"
