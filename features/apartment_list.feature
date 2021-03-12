Feature: display list of movies filtered by MPAA rating

  As a Columbia student looking for off-campus housing
  I want to check out the apartment listings
  So that I can determine which apartment fits the most

  Background: apartment data have been added to database

    Given the following apartment data exist
      | name       | price | rating | image                           | description  | address         |
      | Apartment1 | 1500  | 0      | https://i.imgur.com/OweOwKu.jpg | Apartment 1. | 1 Apple St.     |
      | Apartment2 | 2000  | 0      |                                 | Apartment 2. | 2 Apple St.     |
      | Apartment3 | 2500  | 0      |                                 | Apartment 3! | 3 Banana St.    |
      | Apartment4 | 3000  | 0      |                                 | Apartment 4. | 4 Canal St.     |
      | Apartment5 | 3500  | 0      |                                 | Apartment 5. | 5 Lafayette St. |

    And I am on the listing page
    Then 10 seed apartments should exist
