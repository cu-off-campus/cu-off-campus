Feature: User login, logout, and registration

  As a Columbia student who saw the apartment listing,
  I noticed that I have lived in one of the apartments for a while,
  and I wanted to rate and leave a comment on the apartment which I rent.
  So, I need to register with my columbia uni (or email), and
  I should be able to log on to the website and log out from the website.

  Background: A user is added to the database

    Given the following users exist
      | username | password |
      | user1    | test1    |
    And   the following apartment data exist
      | name       | price | image | description  | address     |
      | Apartment1 | 1500  |       | Apartment 1. | 1 Apple St. |
    Then 1 seed user should exist

  Scenario: Register new user
    When I am on the main page
    And  I click "Sign up"
    Then I should be on the register page

    When I fill in "Email" with "test"
    And  I fill in "input-pw" with "testpassword"
    And  I fill in "input-pw-confirm" with "testpassword"
    And  I click "Submit"
    Then I should be on the listing page
    And  I should see "Successfully registered"
    And  I should see "Welcome, test"
    And  I should see "Log Out"

  @javascript
  Scenario: Password and confirmation don't match (the sad path)
    When I am on the register page
    And  I fill in "Email" with "test2"
    And  I fill in "input-pw" with "pw"
    And  I fill in "input-pw-confirm" with "ab"
    Then I should see "Passwords do not match"
    And  I should not be able to click "Submit"

  Scenario: Duplicate username (the sad path)
    When I am on the register page
    And  I fill in "Email" with "user1"
    And  I fill in "input-pw" with "test"
    And  I fill in "input-pw-confirm" with "test"
    And  I click "Submit"
    Then I should be on the register page
    And  I should see "User with this username already exists."

  Scenario: Log in
    When I am on the main page
    And  I click "Log in"
    Then I should be on the login page
    When I fill in "Email" with "user1"
    And  I fill in "Password" with "test1"
    And  I click "Submit"
    Then I should be on the listing page
    And  I should see "Successfully logged in"
    And  I should see "Welcome, user1"

  Scenario: Fail to log in (the sad path)
    When I go to the login page
    And  I fill in "Email" with "user1"
    And  I fill in "Password" with "no"
    And  I click "Submit"
    Then I should be on the login page
    And  I should see "Wrong username or password."

  Scenario: Log out
    When I am logged in as "user1" with password "test1"
    And  I am on the home page
    And  I click "Log Out"
    Then I should be on the listing page
    And  I should see "Successfully logged out"
