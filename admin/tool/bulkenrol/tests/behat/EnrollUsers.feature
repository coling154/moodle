@tool @tool_bulkenrol @_file_upload
Feature: An admin can enroll users using a CSV file
  In order to enroll users using a CSV file
  As an admin
  I need to be able to upload a CSV file and navigate through the import process

  Background:
    Given the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1 | 0 |

    Given the following "users" exist:
      | username | firstname | lastname | email |
      | stu1 | Student   | 1        | stu1@moodle.com |
      | stu2 | Student   | 2        | stu2@moodle.com |
      | stu3 | Student   | 3        | stu3@moodle.com |
    And I log in as "admin"
    And I click on "Site administration" "link"
    And I click on "Courses" "link"
    And I click on "Bulk Enrollment" "link"

  @javascript
  Scenario: Successful Enrollment of 3 Students from .csv file
    Given I upload "admin/tool/bulkenrol/tests/fixtures/Success_case_csv - Sheet1.csv" file to "File" filemanager
    And I should see "Resolve User"
    And I set the field "Resolve User" to "Email"
    And I set the field "Resolve Course" to "Short Name"
    And I set the field "Resolve Role" to "Short Name"
    And I click on "Preview" "button"
    And I click on "Bulk Enrollment" "button"
    And I should see "Total enrollment items: 3"
    And I should see "Sucessful enrollments: 3"
    And I click on "Continue" "button"
    And I click on "Courses" "link"
    And I click on "Manage courses and categories" "link"
    And I click on "Course 1" "link"
    And I click on "Enrolled users" "link"
    And I should see "Student 1"
    And I should see "Student 2"
    And I should see "Student 3"


  @javascript
  Scenario: Failure case of Enrollment from .csv file

    And the following "course enrolments" exist:
      | user       | course | role           |
      | stu1 | C1   | student |

    Given I upload "admin/tool/bulkenrol/tests/fixtures/Failure_case_csv.csv" file to "File" filemanager
    And I should see "Resolve User"
    And I set the field "Resolve User" to "Email"
    And I set the field "Resolve Course" to "Short Name"
    And I set the field "Resolve Role" to "Short Name"
    And I click on "Preview" "button"
    And I click on "Bulk Enrollment" "button"
