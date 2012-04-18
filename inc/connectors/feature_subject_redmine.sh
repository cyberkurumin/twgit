#!/bin/bash

##
# twgit
#
# Copyright (c) 2011 Twenga SA.
#
# This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/
# or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
#
# @copyright 2012 Geoffroy Aubry <geoffroy.aubry@free.fr>
# @license http://creativecommons.org/licenses/by-nc-sa/3.0/
#



##
# Retrive and display subject of a Redmine's issue.
#
# @param string $1 issue number or project name
#
ref="$1"
issue_url="https://$TWGIT_FEATURE_SUBJECT_REDMINE_DOMAIN/issues/$ref.json?key=$TWGIT_FEATURE_SUBJECT_REDMINE_API_KEY"
project_url="https://$TWGIT_FEATURE_SUBJECT_REDMINE_DOMAIN/projects/$ref.json?key=$TWGIT_FEATURE_SUBJECT_REDMINE_API_KEY"

if [[ "$ref" =~ ^[0-9]+$ ]]; then
    (wget -q -O - --no-cache $issue_url \
    | php -r '$o = json_decode(file_get_contents("php://stdin")); if ($o !== NULL) {print_r($o->issue->subject);}')
    2>/dev/null
else
    (wget -q -O - --no-cache $project_url \
    | php -r '$o = json_decode(file_get_contents("php://stdin")); if ($o !== NULL) {print_r($o->project->name);}')
    2>/dev/null
fi
