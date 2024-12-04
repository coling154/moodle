@tool @course @progress_bar @javascript
Feature: Progress bar updates with correct colors and percentages
  In order to verify progress tracking
  As an admin
  I want to create a course, add assignments, and ensure the progress bar updates accurately with correct colors

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email               | password      |
      | admin    | Matthew     | Parent     | parentmg@clarkson.edu   | Clarkson24!   |

  Scenario: Progress bar updates as assignments are marked as done
    Given I log in as "admin" with password "Clarkson24!"
    And I create a new course named "Progress Bar Test Course"
    And I add 4 assignments to the "Progress Bar Test Course" named "Assignment"
    When I navigate to the "Progress Bar Test Course" course page
    Then I should see "Progress: 0%" in the "Progress Bar" region
    And the "Progress Bar" color should be "red"

    When I mark "Assignment 1" as done
    And I navigate back to the "My courses" page
    Then I should see "Progress: 25%" in the "Progress Bar" region
    And the "Progress Bar" color should be "red"

    When I mark "Assignment 2" as done
    And I navigate back to the "My courses" page
    Then I should see "Progress: 50%" in the "Progress Bar" region
    And the "Progress Bar" color should be "yellow"

    When I mark "Assignment 3" as done
    And I navigate back to the "My courses" page
    Then I should see "Progress: 75%" in the "Progress Bar" region
    And the "Progress Bar" color should be "green"

    When I mark "Assignment 4" as done
    And I navigate back to the "My courses" page
    Then I should see "Progress: 100%" in the "Progress Bar" region
    And the "Progress Bar" color should be "green"
