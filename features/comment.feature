Feature: Comments for apartments

  As a Columbia student who saw the apartment listing,
  I noticed that I have lived in one of the apartments for a while,
  and I wanted to rate and leave a comment on the apartment which I rent.
  So, I need to login and write a comment, or edit or delete my comment.

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

    And the following comments exist
      | apartment_id | user_id | rating | comment     | tags  |
      | 1            | 1       | 80     | Good        | 5UA   |
      | 1            | 2       | 70     | Lorem ipsum | 5VY   |
      | 2            | 2       | 75     | OK          | 5W,5X |
      | 3            | 3       | 85     | Great       | 5YM   |
      | 4            | 4       | 68     | Not good    | 5ZJ   |

    Then 5 seed apartments should exist
    And  4 seed users should exist
    And  5 seed comments should exist

  Scenario: Existing comment can be seen by everyone
    When I am on the details page for "Apartment1"
    Then I should see the following in order
      | $1500       |
      | 75          |
      | 2           |
      | 5VY         |
      | Lorem ipsum |
      | 5UA         |
      | Good        |

  @javascript
  Scenario: Write a new comment
    When I am logged in as "user1" with password "test1"
    And I am on the details page for "Apartment5"
    Then I should see the following in order
      | RATING   |
      | 0        |
      | COMMENTS |
      | 0        |
    When I click "Write a Comment"
    Then I should be on the new comment page for "Apartment5"

    When I fill in "input-rating" with "80"
    And  I fill in "input-comment" with "a b c d e f g h i j k l m n o p q r s t u v w x y z a b c d e f g h i j k l m n o p q r s t u v w x y z"
    And  I fill in "input-tags" with "5AB,3CD"
    And  I click "Save"
    Then I should see "Commented successfully."
    And  I should be on the details page for "Apartment5"
    And  I should see the following in order
      | 5AB           |
      | 3CD           |
      | a b c d e f g |
    And  I should see "a b c d e f g h i j k l m n o p q r s t u v w x y z a b c d e f g h i j k l m n o p q r s t u v w x y z"
    And  I should see the following in order
      | RATING   |
      | 80       |
      | COMMENTS |
      | 1        |

  Scenario: Cannot write a comment when not signed in (the sad path)
    When I am on the details page for "Apartment5"
    And  I click "Write a Comment"
    Then I should be on the details page for "Apartment5"
    And  I should see "You must be signed in to write a comment."

  @javascript
  Scenario: Invalid comment (the sad path)
    When I am logged in as "user1" with password "test1"
    And  I am on the new comment page for "Apartment5"
    And  I fill in "input-rating" with "80"
    And  I fill in "input-comment" with "a b"
    Then I should see "You need 48 more words to comment."
    And  I should not be able to click "Save"

    When I fill in "input-comment" with "a b c d e f g h i j k l m n o p q r s t u v w x y z a b c d e f g h i j k l m n o p q r s t u v w x y z"
    And  I fill in "input-rating" with "120"
    Then I should see "The rating must be an integer between 0 and 100"
    And  I should not be able to click "Save"

  Scenario: Delete a comment
    When I am logged in as "user1" with password "test1"
    And  I am on the details page for "Apartment1"
    Then I should see "Good"
    And  I should see "Lorem ipsum"

    When I click "delete-comment-1"
    Then I should be on the details page for "Apartment1"
    And  I should see "Successfully deleted the comment."
    And  I should not see "Good"
    And  I should see "Lorem ipsum"

  Scenario: Edit a comment
    When I am logged in as "user1" with password "test1"
    And  I am on the details page for "Apartment1"
    Then I should see "Good"
    And  I should see "Lorem ipsum"

    When I click "edit-comment-1"
    Then I should be on the edit comment page for apartment "Apartment1" and comment 1

    When I fill in "input-rating" with "90"
    And  I fill in "input-tags" with "5AB,3CD"
    And  I fill in "input-comment" with "a b c d e f g h i j k l m n o p q r s t u v w x y z a b c d e f g h i j k l m n o p q r s t u v w x y z"
    And  I click "Save"
    Then I should be on the details page for "Apartment1"
    And  I should see "Your comment was successfully updated."
    And  I should see the following in order
      | RATING      |
      | 80          |
      | COMMENTS    |
      | 2           |
      | user1       |
      | 5AB         |
      | 3CD         |
      | a b c d     |
      | Lorem ipsum |
    And  I should not see "Good"
    And  I should not see "5UA"
