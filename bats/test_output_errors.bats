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

@test "check output errors (syntax error, no mode, failfast=True)" {
  # check output
  PART_ID="DBCD"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": 0,' ]
  # check title
  run bash -c "grep -E \".*feedback.*Test result of the task: .*Example task.*\" $REPORT"
  [ "$status" = 0 ]
  # check statistics line not in output
  run bash -c "grep -E \".*Total tests: 19. Total testing time:*\" $REPORT"
  [ "$status" = 1 ]
  # check error message
  run bash -c "grep -E \".*The grader crashed. Check for syntax errors in your solution and the ability*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*to import it as a module. If the error reappears, please contact the support*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*administrator.*\" $REPORT"
  [ "$status" = 0 ]
  # check traceback
  run bash -c "grep -E \".*E   SyntaxError: invalid syntax*\" $REPORT"
  [ "$status" = 0 ]
  # check resume
  run bash -c "grep -E \".*Try again.*\" $REPORT"
  [ "$status" = 0 ]
  }
