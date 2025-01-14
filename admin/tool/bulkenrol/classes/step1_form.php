<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * File containing the step 1 of the upload form.
 *
 * @package    tool_bulkenrol
 * @copyright  2013 Frédéric Massart
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

defined('MOODLE_INTERNAL') || die();

require_once($CFG->libdir.'/formslib.php');

/**
 * Upload a file CVS file with bulk enrollment information.
 *
 * @package    tool_bulkenrol
 * @copyright  2011 Piers Harding
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
class tool_bulkenrol_step1_form extends tool_bulkenrol_base_form {

    /**
     * The standard form definiton.
     * @return void
     */
    public function definition () {
        $mform = $this->_form;

        $mform->addElement('header', 'generalhdr', get_string('general'));

        $mform->addElement('filepicker', 'enrolfile', get_string('enrolfile', 'tool_bulkenrol'));
        $mform->addRule('enrolfile', null, 'required');
        $mform->addHelpButton('enrolfile', 'enrolfile', 'tool_bulkenrol');

        $choices = csv_import_reader::get_delimiter_list();
        $mform->addElement('select', 'delimiter_name', get_string('csvdelimiter', 'tool_bulkenrol'), $choices);
        if (array_key_exists('cfg', $choices)) {
            $mform->setDefault('delimiter_name', 'cfg');
        } else if (get_string('listsep', 'langconfig') == ';') {
            $mform->setDefault('delimiter_name', 'semicolon');
        } else {
            $mform->setDefault('delimiter_name', 'comma');
        }
        $mform->addHelpButton('delimiter_name', 'csvdelimiter', 'tool_bulkenrol');

        $choices = core_text::get_encodings();
        $mform->addElement('select', 'encoding', get_string('encoding', 'tool_bulkenrol'), $choices);
        $mform->setDefault('encoding', 'UTF-8');
        $mform->addHelpButton('encoding', 'encoding', 'tool_bulkenrol');

        $choices = array('10' => 10, '20' => 20, '100' => 100, '1000' => 1000, '100000' => 100000);
        $mform->addElement('select', 'previewrows', get_string('rowpreviewnum', 'tool_bulkenrol'), $choices);
        $mform->setType('previewrows', PARAM_INT);
        $mform->addHelpButton('previewrows', 'rowpreviewnum', 'tool_bulkenrol');

        $this->add_import_options();

        $mform->addElement('hidden', 'showpreview', 1);
        $mform->setType('showpreview', PARAM_INT);

        $this->add_action_buttons(false, get_string('preview', 'tool_bulkenrol'));
    }
}
