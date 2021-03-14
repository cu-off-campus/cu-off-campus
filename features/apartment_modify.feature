Feature: Adding and editing apartment information

  As a Columbia student who has rented some off-campus housing
  I want to modify some information that might be incorrect in the apartment listing
    and add some new apartment resources

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

  Scenario: Add new apartment
    When I go to the listing page
    And  I click "Add new apartment"
    Then I should be on the new apartment page
    When I fill in "Name" with "Test Apartment"
    And  I fill in "Price" with "5000"
    And  I fill in "Address" with "Fake address"
    And  I click "Save"
    Then I should be on the listing page
    And  I should see "Test Apartment"
    And  I should see "Fake address"

  Scenario: Fail to add new apartment if the input is bad (the sad path)
    When I go to the new apartment page
    And  I click "Save"
    Then I should be on the new apartment page
    And  I should see "Invalid parameters"

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

  Scenario: Fail to edit an existing apartment if the input is bad (the sad path)
    When I go to the editing page for "Apartment1"
    And  I fill in "Price" with "abc"
    And  I click "Update"
    Then I should be on the editing page for "Apartment1"
    And  I should see "Invalid parameters"
    And  the "Price" field should contain "1500"
