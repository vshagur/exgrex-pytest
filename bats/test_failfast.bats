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


@test "check output for failfast True (no mode)" {
  # check output for no mode and failfast=True
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

@test "check output for failfast False (no mode)" {
  # check output for no mode and failfast=False
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
  run bash -c "grep -E \".*Total tests: 19. Tests failed: 7. Total testing time:*\" $REPORT"
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


@test "check output for failfast False (line mode)" {
  # check output for line mode and failfast=False
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
  run bash -c "grep -E \".*Total tests: 19. Tests failed: 7. Total testing time:*\" $REPORT"
  [ "$status" = 0 ]
  # check error message
  run bash -c "grep -E \".*\[Failed\] test_2.*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] test_5.*\" $REPORT"
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


@test "check output for failfast False (short mode)" {
  # check output for short mode and failfast=False
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
  run bash -c "grep -E \".*Total tests: 19. Tests failed: 7. Total testing time:*\" $REPORT"
  [ "$status" = 0 ]
  # check error message
  run bash -c "grep -E \".*\[Failed\] test_2.*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] test_5.*\" $REPORT"
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
  # check error comment
  run bash -c "grep -E \".*AssertionError: Test 2. assert message test_2*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*AssertionError: Test 5. assert message test_5*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*AssertionError: Test 7.assert message test_7*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*AssertionError: Test 9. assert message test_9*\" $REPORT"
  [ "$status" = 0 ]
  # check assert not in output
  run bash -c "grep -E \".*TypeError: 'NoneType' object is not callable*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*assert 'asdf' == 'rty'*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*assert 3 in (4, 5)*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*assert [1, 2, 3] == [1, 2, 3, 4]*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*assert 1 == 5*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*assert 1 in (4, 5)*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*assert 2 in (4, 5)*\" $REPORT"
  [ "$status" = 0 ]
  # check traceback
  run bash -c "grep -E \".*where 1 = summa(1, 0)*\" $REPORT"
  [ "$status" = 0 ]
  # check resume
  run bash -c "grep -E \".*Not passed. Try again.*\" $REPORT"
  [ "$status" = 0 ]
}

@test "check output for failfast False (long mode)" {
  # check output for long mode and failfast=False
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
  run bash -c "grep -E \".*Total tests: 19. Tests failed: 7. Total testing time:*\" $REPORT"
  [ "$status" = 0 ]
  # check error message
  run bash -c "grep -E \".*\[Failed\] test_2.*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*\[Failed\] test_5.*\" $REPORT"
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
  # check error comment
  run bash -c "grep -E \".*AssertionError: Test 2. assert message test_2*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*AssertionError: Test 5. assert message test_5*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*AssertionError: Test 7.assert message test_7*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*AssertionError: Test 9. assert message test_9*\" $REPORT"
  [ "$status" = 0 ]
  # check assert not in output
  run bash -c "grep -E \".*TypeError: 'NoneType' object is not callable*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*assert 'asdf' == 'rty'*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*assert 3 in (4, 5)*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*assert [1, 2, 3] == [1, 2, 3, 4]*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*assert 1 == 5*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*assert 1 in (4, 5)*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*assert 2 in (4, 5)*\" $REPORT"
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
  run bash -c "grep -E \".*def test_5():*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*@pytest.mark.parametrize('value', [1, 2, 3, 4, 5])*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*def test_7(value)*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*value = 1*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*value = 2*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*value = 3*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*new_summa = None*\" $REPORT"
  [ "$status" = 0 ]
  # check number line message
  run bash -c "grep -E \".*tests/test_example.py:23: AssertionError*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*tests/test_example.py:52: AssertionError*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*tests/test_example.py:81: AssertionError*\" $REPORT"
  [ "$status" = 0 ]
  run bash -c "grep -E \".*tests/test_example.py:87: TypeError*\" $REPORT"
  [ "$status" = 0 ]
}
