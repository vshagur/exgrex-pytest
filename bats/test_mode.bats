#!/usr/bin/env bats

# set grader name
GRADER="grader_a"

setup() {
  CWD="$PWD"
  REPORT="$PWD/TestGraders/$GRADER/shared/feedback.json"
  COMMAND="$(dirname $PWD)/.env/bin/exgrexCourseraPy"
  cd "TestGraders/$GRADER"
}

teardown() {
  cd "$CWD"
}


@test "check output default mode" {
  # check output with parameters by default
  PART_ID="ABCD"
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
  run bash -c "grep -E \".*Total tests: 19. Total testing time:*\" $REPORT"
  [ "$status" = 0 ]
  # check error message
  run bash -c "grep -E \".*\[Failed\] test_2.*\" $REPORT"
  [ "$status" = 0 ]
  # check error comment
  run bash -c "grep -E \".*AssertionError: Test 2. assert message test_2*\" $REPORT"
  [ "$status" = 0 ]
  # check assert
  run bash -c "grep -E \".*assert 1 == 5*\" $REPORT"
  [ "$status" = 0 ]
  # check traceback
  run bash -c "grep -E \".*where 1 = summa(1, 0)*\" $REPORT"
  [ "$status" = 0 ]
  # check resume
  run bash -c "grep -E \".*Not passed. Try again.*\" $REPORT"
  [ "$status" = 0 ]
}

@test "check output no mode" {
  # check output for no mode
  PART_ID="ABCE"
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
  run bash -c "grep -E \".*Total tests: 19. Total testing time:*\" $REPORT"
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

@test "check output short mode" {
  # check output for short mode
  PART_ID="ABCF"
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
  run bash -c "grep -E \".*Total tests: 19. Total testing time:*\" $REPORT"
  [ "$status" = 0 ]
  # check error message
  run bash -c "grep -E \".*\[Failed\] test_2.*\" $REPORT"
  [ "$status" = 0 ]
  # check error comment
  run bash -c "grep -E \".*AssertionError: Test 2. assert message test_2*\" $REPORT"
  [ "$status" = 0 ]
  # check assert
  run bash -c "grep -E \".*assert 1 == 5*\" $REPORT"
  [ "$status" = 0 ]
  # check traceback
  run bash -c "grep -E \".*where 1 = summa(1, 0)*\" $REPORT"
  [ "$status" = 0 ]
  # check resume
  run bash -c "grep -E \".*Not passed. Try again.*\" $REPORT"
  [ "$status" = 0 ]
}

@test "check output line mode" {
  # check output for line mode
  PART_ID="ABCH"
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
  run bash -c "grep -E \".*Total tests: 19. Total testing time:*\" $REPORT"
  [ "$status" = 0 ]
  # check error message
  run bash -c "grep -E \".*\[Failed\] test_2.*\" $REPORT"
  [ "$status" = 0 ]
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

@test "check output long mode" {
  # check output with for long mode
  PART_ID="ABCG"
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
  run bash -c "grep -E \".*Total tests: 19. Total testing time:*\" $REPORT"
  [ "$status" = 0 ]
  # check error message
  run bash -c "grep -E \".*\[Failed\] test_2.*\" $REPORT"
  [ "$status" = 0 ]
  # check error comment
  run bash -c "grep -E \".*AssertionError: Test 2. assert message test_2*\" $REPORT"
  [ "$status" = 0 ]
  # check assert
  run bash -c "grep -E \".*assert 1 == 5*\" $REPORT"
  [ "$status" = 0 ]
  # check traceback
  run bash -c "grep -E \".*where 1 = summa(1, 0)*\" $REPORT"
  [ "$status" = 0 ]
  # check resume
  run bash -c "grep -E \".*Not passed. Try again.*\" $REPORT"
  [ "$status" = 0 ]
  # check code
  run bash -c "grep -E \".*def test_2(new_summa)*\" $REPORT"
  [ "$status" = 0 ]
  # check number line message
  run bash -c "grep -E \".*test_example.py:23: AssertionError*\" $REPORT"
  [ "$status" = 0 ]
}


