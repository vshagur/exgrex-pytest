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

@test "check output passrate (no mode)" {
  # check output for no mode and failfast=True, passrate default
  PART_ID="BBCD"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": 0,' ]
  # check passrate line not in message
  run bash -c "grep -E \".*Not passed. Score*\" $REPORT"
  [ "$status" = 1 ]
  # check resume
  run bash -c "grep -E \".*Not passed. Try again.*\" $REPORT"
  [ "$status" = 0 ]
  }

@test "check output passrate (tests failed, line mode, failfast False, passrate 0.64)" {
  # check output
  PART_ID="BBCE"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": 0.63,' ]
  # check resume
  run bash -c "grep -E \".*Not passed. Score: 63 points out of 100. *\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*To pass the test, you need to score 64 points.*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*Try again.*\" $REPORT"
  [ "$status" = 0 ]
 }

@test "check output passrate (tests passed, short mode, failfast False, passrate 0.63)" {
  # check output
  PART_ID="BBCF"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": 1,' ]
  # check resume
  run bash -c "grep -E \".*Passed. Score: 63 points out of 100.*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*You have scored the required number of points to pass the test.*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*If you want, you can try to take the test again and get a higher grade.*\" $REPORT"
  [ "$status" = 0 ]
}

@test "check output passrate (tests failed, long mode, failfast False, passrate 0.82)" {
  # check output
  PART_ID="BBCG"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": 0.63,' ]
  # check resume
  run bash -c "grep -E \".*Not passed. Score: 63 points out of 100. *\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*To pass the test, you need to score 82 points.*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*Try again.*\" $REPORT"
  [ "$status" = 0 ]
 }

@test "check output passrate (tests passed, line mode, failfast False, passrate 0.5)" {
  # check output
  PART_ID="BBCH"
  # delete the contents of the report file
  echo "" > $REPORT
  run bash -c "env partId=$PART_ID $COMMAND"
  [ "$status" = 0 ]
  run bash -c "cat $REPORT"
  # check score string
  [ ${lines[1]} = '  "fractionalScore": 1,' ]
  # check resume
  run bash -c "grep -E \".*Passed. Score: 63 points out of 100.*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*You have scored the required number of points to pass the test.*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*If you want, you can try to take the test again and get a higher grade.*\" $REPORT"
  [ "$status" = 0 ]
}