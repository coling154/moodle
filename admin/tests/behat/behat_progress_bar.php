<?php

require_once(__DIR__ . '/../../../lib/behat/behat_base.php');

use Moodle\BehatExtension\Context\BehatContext;
use Behat\Mink\Exception\ElementNotFoundException as ElementNotFoundException;

/**
 * Behat step definitions for testing the progress bar feature.
 */
class behat_progress_bar extends behat_base {

    /**
     * Logs in as a specific user.
     *
     * @Given /^I log in as "(?P<username>(?:[^"]|\\")*)" with password "(?P<password>(?:[^"]|\\")*)"$/
     * @throws Exception
     */
    public function i_log_in_as_with_password($username, $password) {
        $this->execute('behat_auth::i_log_in_as', [$username, $password]);
    }

    /**
     * Navigates to a specific course page.
     *
     * @When /^I navigate to the "(?P<course>(?:[^"]|\\")*)" course page$/
     * @throws Exception
     */
    public function i_navigate_to_the_course_page($course) {
        $this->execute('behat_general::i_click_on_in_the', ['button', 'nav']); // Button with three lines
        $this->execute('behat_navigation::i_navigate_to_in', [$course, 'My courses']);
    }

    /**
     * Navigates back to the "My courses" page.
     *
     * @When /^I navigate back to the "My courses" page$/
     * @throws Exception
     */
    public function i_navigate_back_to_the_my_courses_page() {
        $this->execute('behat_general::i_click_on_in_the', ['button', 'nav']);
        $this->execute('behat_navigation::i_navigate_to_in', ['My courses', 'Dashboard']);
    }

    /**
     * Creates a new course with a specified name.
     *
     * @Given /^I create a new course named "(?P<coursename>(?:[^"]|\\")*)"$/
     * @throws Exception
     */
    public function i_create_a_new_course_named($coursename) {
        $this->execute('behat_general::i_click_on_in_the', ['button', 'nav']);
        $this->execute('behat_navigation::i_navigate_to_in', ['My courses', 'Dashboard']);
        $this->execute('behat_general::i_click_on_in_the', ['Create new course', 'My courses']);
        $this->execute('behat_forms::i_set_the_field', ['Course full name', $coursename]);
        $this->execute('behat_forms::i_set_the_field', ['Course short name', $coursename]);
        $this->execute('behat_forms::i_press_button', ['Save and display']);
    }

    /**
     * Adds assignments to a course.
     *
     * @Given /^I add (?P<count>\d+) assignments to the "(?P<coursename>(?:[^"]|\\")*)" named "(?P<prefix>(?:[^"]|\\")*)"$/
     * @throws Exception
     */
    public function i_add_assignments_to_the_named($count, $coursename, $prefix) {
        for ($i = 1; $i <= $count; $i++) {
            $assignmentname = "$prefix $i";
            $this->execute('behat_navigation::i_navigate_to_in', ['Add an activity or resource', 'Course administration']);
            $this->execute('behat_forms::i_set_the_field', ['Activity name', $assignmentname]);
            $this->execute('behat_forms::i_press_button', ['Save and return to course']);
        }
    }

    /**
     * Marks an assignment as done.
     *
     * @When /^I mark "(?P<assignmentname>(?:[^"]|\\")*)" as done$/
     * @throws Exception
     */
    public function i_mark_as_done($assignmentname) {
        $this->execute('behat_general::i_click_on_in_the', ['Mark as done', $assignmentname]);
    }

    /**
     * Verifies progress bar percentage.
     *
     * @Then /^I should see "Progress: (?P<percentage>\d+)%" in the "Progress Bar" region$/
     */
    public function i_should_see_progress_in_the_progress_bar_region($percentage) {
        $progressbarxpath = "//div[contains(@class, 'progress-bar') and contains(@style, '$percentage%')]";
        $this->find('xpath', $progressbarxpath);
    }

    /**
     * Verifies progress bar color.
     *
     * @Then /^the "Progress Bar" color should be "(?P<color>\w+)"$/
     */
    public function the_progress_bar_color_should_be($color) {
        $colorclass = [
            'red' => 'bg-danger',
            'yellow' => 'bg-warning',
            'green' => 'bg-success'
        ][$color];
        $this->find('xpath', "//div[contains(@class, '$colorclass')]");
    }
}
