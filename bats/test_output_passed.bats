#!/usr/bin/env bats

# set grader name
GRADER="grader_b"

setup() {
  CWD="$PWD"
  REPORT="$PWD/TestGraders/$GRADER/shared/feedback.json"
  COMMAND="$(dirname $PWD)/.env/bin/exgrexCourseraPy"
  cd "TestGraders/$GRADER"
}

teardown() {
  cd "$CWD"
}

@test "check output (all tests passed)" {
  # check output
  PART_ID="CBCH"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": 1,' ]
  # check title
  run bash -c "grep -E \".*feedback.*Test result of the task: .*Example task.*\" $REPORT"
  [ "$status" = 0 ]
  # check statistics line
  run bash -c "grep -E \".*Total tests: 10. Tests failed: 0. Total testing time*\" $REPORT"
  [ "$status" = 0 ]
  # check message
  run bash -c "grep -E \".*All tests passed.*\" $REPORT"
  [ "$status" = 0 ]
  }
