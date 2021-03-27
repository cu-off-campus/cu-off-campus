Feature: Adding and editing apartment information

  As a Columbia student who has rented some off-campus housing
  I want to modify some information that might be incorrect in the apartment listing
  and add some new apartment resources

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

  @javascript
  Scenario: Add new apartment
    When I am on the listing page
    And  I click "Add new apartment"
    Then I should be on the new apartment page
    When I fill in "input-aptmt-name" with "Test Apartment"
    And  I fill in "input-price" with "5000"
    And  I fill in "input-addr" with "Fake address"
    And  I click "btn-save"
    Then I should be on the listing page
    And  I should see "Test Apartment"
    And  I should see "Fake address"

  Scenario: Cancel to add new apartment
    When I am on the listing page
    And  I click "Add new apartment"
    Then I should be on the new apartment page
    When I click "Cancel"
    Then I should be on the listing page

  @javascript
  Scenario: Fail to add new apartment if the input is bad (the sad path)
    When I go to the new apartment page
    And  I fill in "input-aptmt-name" with "Test Apartment"
    And  I fill in "input-price" with "abc"
    And  I fill in "input-addr" with "Fake address"
    Then I should see "This field must be integer only."
    And  I should not be able to click "Save"

  @javascript
  Scenario: Edit an existing apartment
    When I am on the details page for "Apartment1"
    And  I click "Edit Info"
    Then I should be on the editing page for "Apartment1"
    When I fill in "Price" with "3300"
    And  I fill in "Description" with "Apartment 1 has a good environment."
    And  I click "Update"
    Then I should be on the details page for "Apartment1"
    And  I should see "3300"
    And  I should see "a good environment"

  Scenario: Cancel to edit apartment information
    When I am on the details page for "Apartment1"
    And  I click "Edit Info"
    Then I should be on the editing page for "Apartment1"
    When I click "Cancel"
    Then I should be on the details page for "Apartment1"

  @javascript
  Scenario: Fail to edit an existing apartment if the input is bad (the sad path)
    When I go to the editing page for "Apartment1"
    And  I fill in "Price" with "abc"
    Then I should see "This field must be integer only."
    And  I should not be able to click "Update"
