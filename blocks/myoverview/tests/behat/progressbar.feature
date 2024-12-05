@core @core_course @core_courseformat
Feature: Course index completion icons
  In order to quickly check my activities completions
  As a student
  I need to see the activity completion in the course index.

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Teacher   | 1        | teacher1@example.com |
      | student1 | Student   | 1        | student1@example.com |
    And the following "course" exists:
      | fullname         | Course 1 |
      | shortname        | C1       |
      | category         | 0        |
      | enablecompletion | 1        |
      | numsections      | 4        |

    And the following "activities" exist:
      | activity | name              | intro                       | course | idnumber | section | completion |
      | assign   | Activity sample 1 | Test assignment description | C1     | sample1  | 1       | 1          |
      | assign   | Activity sample 2 | Test assignment description | C1     | sample2  | 1       | 1          |
      | assign   | Activity sample 3 | Test assignment description | C1     | sample3  | 1       | 1          |
      | assign   | Activity sample 4 | Test assignment description | C1     | sample4  | 1       | 1          |
      | assign   | Activity sample 5 | Test assignment description | C1     | sample5  | 1       | 1          |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | student1 | C1     | student        |
      | teacher1 | C1     | editingteacher |
    # The course index is hidden by default in small devices.


  @javascript
  Scenario: Manual completion in an activity page should update the course progress bar
    Given I am on the "sample1" "Activity" page logged in as "student1"
    And "To do" "icon" should exist in the "courseindex-content" "region"
    When I press "Mark as done"
    And I wait until "Done" "button" exists
    And "Done" "icon" should exist in the "courseindex-content" "region"
    And I press "Done"
    And I should see "My courses"
    Then I click on "My courses" "link"
    Then I should see "My courses"
    And the field with xpath "//meter[@id='progress-bar']" matches value "0"

    Then I click on "Course 1" "link"
    Then I should see "Activity sample 1"
    And I click on "Activity sample 1" "link"
    When I press "Mark as done"
    And I wait until "Done" "button" exists
    And "Done" "icon" should exist in the "courseindex-content" "region"
    And I should see "My courses"
    Then I click on "My courses" "link"
    Then I should see "My courses"
    And the field with xpath "//meter[@id='progress-bar']" matches value "20"

    Then I click on "Course 1" "link"
    Then I should see "Activity sample 2"
    And I click on "Activity sample 2" "link"
    When I press "Mark as done"
    And I wait until "Done" "button" exists
    And "Done" "icon" should exist in the "courseindex-content" "region"
    And I should see "My courses"
    Then I click on "My courses" "link"
    Then I should see "My courses"
    And the field with xpath "//meter[@id='progress-bar']" matches value "40"

    Then I click on "Course 1" "link"
    Then I should see "Activity sample 3"
    And I click on "Activity sample 3" "link"
    When I press "Mark as done"
    And I wait until "Done" "button" exists
    And "Done" "icon" should exist in the "courseindex-content" "region"
    And I should see "My courses"
    Then I click on "My courses" "link"
    Then I should see "My courses"
    And the field with xpath "//meter[@id='progress-bar']" matches value "60"

    Then I click on "Course 1" "link"
    Then I should see "Activity sample 4"
    And I click on "Activity sample 4" "link"
    When I press "Mark as done"
    And I wait until "Done" "button" exists
    And "Done" "icon" should exist in the "courseindex-content" "region"
    And I should see "My courses"
    Then I click on "My courses" "link"
    Then I should see "My courses"
    And the field with xpath "//meter[@id='progress-bar']" matches value "80"

    Then I click on "Course 1" "link"
    Then I should see "Activity sample 5"
    And I click on "Activity sample 5" "link"
    When I press "Mark as done"
    And I wait until "Done" "button" exists
    And "Done" "icon" should exist in the "courseindex-content" "region"
    And I should see "My courses"
    Then I click on "My courses" "link"
    Then I should see "My courses"
    And the field with xpath "//meter[@id='progress-bar']" matches value "100"