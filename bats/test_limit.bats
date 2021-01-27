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

@test "check output (no mode, limits 2)" {
  # check output
  PART_ID="CBCD"
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
  # check statistics line
  run bash -c "grep -E \".*Total tests: 19. Tests failed: 7. Total testing time*\" $REPORT"
  [ "$status" = 0 ]
  # check error message
  run bash -c "grep -E \".*Incorrect answer.*\" $REPORT"
  [ "$status" = 0 ]
  # check error message not in output
  run bash -c "grep -E \".*\[Failed\] test_2.*\" $REPORT"
  [ "$status" = 1 ]
  # check error comment not in output
  run bash -c "grep -E \".*AssertionError: Test 2. assert message test_2*\" $REPORT"
  [ "$status" = 1 ]
  # check assert not in output
  run bash -c "grep -E \".*assert 1 == 5*\" $REPORT"
  [ "$status" = 1 ]
  # check traceback not in output
  run bash -c "grep -E \".*where 1 = summa(1, 0)*\" $REPORT"
  [ "$status" = 1 ]
  # check resume
  run bash -c "grep -E \".*Not passed. Try again.*\" $REPORT"
  [ "$status" = 0 ]
}

@test "check output (line mode, limits 3)" {
  # check output
  PART_ID="CBCE"
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
  # check statistics line
  run bash -c "grep -E \".*Total tests: 19. Tests failed: 7. Total testing time*\" $REPORT"
  [ "$status" = 0 ]
  # check error message
  run bash -c "grep -E \".*\[Failed\] test_2.*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] test_5..*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] test_7\[1\].*\" $REPORT"
  [ "$status" = 0 ]
  # check error message not in output
  run bash -c "grep -E \".*\[Failed\] test_7\[2\].*\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E \".*\[Failed\] test_7\[3\].*\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E \".*\[Failed\] TestExample.test_9.*\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E \".*\[Failed\] TestExample.test_11.*\" $REPORT"
  [ "$status" = 1 ]
  # check resume
  run bash -c "grep -E \".*Not passed. Try again.*\" $REPORT"
  [ "$status" = 0 ]
}

@test "check output (short mode, limits 4)" {
  # check output
  PART_ID="CBCF"
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
  # check statistics line
  run bash -c "grep -E \".*Total tests: 19. Tests failed: 7. Total testing time*\" $REPORT"
  [ "$status" = 0 ]
  # check error message
  run bash -c "grep -E \".*\[Failed\] test_2.*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] test_5..*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] test_7\[1\].*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] test_7\[2\].*\" $REPORT"
  [ "$status" = 0 ]
  # check error message not in output
  run bash -c "grep -E \".*\[Failed\] test_7\[3\].*\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E \".*\[Failed\] TestExample.test_9.*\" $REPORT"
  [ "$status" = 1 ]
  run bash -c "grep -E \".*\[Failed\] TestExample.test_11.*\" $REPORT"
  [ "$status" = 1 ]
  # check resume
  run bash -c "grep -E \".*Not passed. Try again.*\" $REPORT"
  [ "$status" = 0 ]
}

@test "check output (long mode, limits 10)" {
  # check output
  PART_ID="CBCG"
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
  # check statistics line
  run bash -c "grep -E \".*Total tests: 19. Tests failed: 7. Total testing time*\" $REPORT"
  [ "$status" = 0 ]
  # check error message
  run bash -c "grep -E \".*\[Failed\] test_2.*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] test_5..*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] test_7\[1\].*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] test_7\[2\].*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] test_7\[3\].*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] TestExample.test_9.*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] TestExample.test_11.*\" $REPORT"
  [ "$status" = 0 ]
  # check resume
  run bash -c "grep -E \".*Not passed. Try again.*\" $REPORT"
  [ "$status" = 0 ]
}
