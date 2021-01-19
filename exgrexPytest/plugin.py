import logging
import time
from pathlib import Path

import pytest
from exgrex.graders import createFileLogger

SEPARATOR = '=' * 70

# https://stackoverflow.com/questions/53249304/how-to-list-all-existing-loggers-using-python-logging-module
loggers = logging.root.manager.loggerDict.keys()

# for the case when tests are run from the command line without using exgrex
if not 'scoreLogger' in loggers and not 'feedbackLogger' in loggers:
    scoreLogFile = Path(Path.cwd(), 'score.log')
    feedbackLogFile = Path(Path.cwd(), 'feedback.log')

    if scoreLogFile.exists():
        scoreLogFile.write_text('')

    if feedbackLogFile.exists():
        feedbackLogFile.write_text('')

    scoreLogger = createFileLogger(
        'scoreLogger', scoreLogFile, '%(message)s'
    )
    feedbackLogger = createFileLogger(
        'feedbackLogger', feedbackLogFile, '%(message)s'
    )

# messages templates
TITLE = 'Total tests: {}. Tests failed: {}. Total testing time: {}.'
POSITIVE_MESSAGE = "All tests passed."
FAILED_TESTS_MESSAGE = '[Failed] {}.\n{}'
ERROR_GRADER_MESSAGE = \
    'The grader crashed. Check for syntax errors in your solution and the ability\n' \
    'to import it as a module. If the error reappears, please contact the support\n' \
    'administrator. \n\n{}'


def pytest_addoption(parser):
    group = parser.getgroup(
        'grader',
        'Creates a report for an external mook course grader and saves it to a file.'
    )
    group._addoption(
        '--grader-mode', dest='grader_mode', metavar='grader-mode',
        action="store",
        choices=['default', 'user'],
        type="choice",
        help='sets one and preset reporting modes for external mook courses grader')

    group._addoption(
        '--taskname', dest='taskname', metavar='taskname',
        action="store",
        type=str,
        help='sets taskname')


@pytest.hookimpl()
def pytest_sessionstart(session):
    if session.config.getoption('grader_mode'):
        # TODO:
        # created vshagur@gmail.com, 2021-01-16
        taskname = session.config.getoption('taskname')
        feedbackLogger.error(SEPARATOR)
        feedbackLogger.error(f'Test result of the task: "{taskname}"')
        feedbackLogger.error(SEPARATOR)


@pytest.hookimpl()
def pytest_configure(config):
    if config.getoption('grader_mode'):
        setattr(config, 'grader_errors', [])
        setattr(config, 'grader_failed', [])
        setattr(config, 'grader_start_time', time.time())


@pytest.hookimpl(trylast=True)
def pytest_collectreport(report):
    if report.outcome == 'failed':
        loggers = logging.root.manager.loggerDict.keys()

        if 'scoreLogger' in loggers and 'feedbackLogger' in loggers:
            scoreLogger.error(0)
            feedbackLogger.error(ERROR_GRADER_MESSAGE.format(report.longrepr.longrepr))


@pytest.hookimpl(hookwrapper=True)
def pytest_runtest_makereport(item, call):
    outcome = yield
    result = outcome.get_result()

    if item.config.getoption('grader_mode'):
        if result.when in ('setup', 'teardown') and result.outcome == 'failed':
            item.config.grader_errors.append(
                ERROR_GRADER_MESSAGE.format(result.longrepr)
            )

        elif result.when == 'call' and result.outcome == 'failed':
            _, _, testname = result.location
            message = FAILED_TESTS_MESSAGE.format(
                testname, result.longrepr.reprcrash.message)
            item.config.grader_failed.append(message)


@pytest.hookimpl(trylast=True)
def pytest_sessionfinish(session, exitstatus):
    if session.config.getoption('grader_mode'):

        if Path(scoreLogger.handlers[0].baseFilename).read_text().strip() == '0':
            feedbackLogger.error(SEPARATOR)
            feedbackLogger.error('Try again.')
        else:
            statistics = TITLE.format(
                session.testscollected,
                session.testsfailed,
                round(time.time() - session.config.grader_start_time, 4)
            )

            feedbackLogger.error(statistics)

            if session.config.grader_errors:
                feedback = (session.config.grader_errors[0],)
            elif session.config.grader_failed:
                feedback = session.config.grader_failed
            else:
                feedback = (POSITIVE_MESSAGE,)
            for testReport in feedback:
                feedbackLogger.error(SEPARATOR)
                feedbackLogger.error(testReport)

            # TODO: add logic for part score (0.0 - 1.0)
            # created vshagur@gmail.com, 2021-01-16
            score = abs(int(exitstatus) - 1)
            scoreLogger.error(score)

            if session.config.grader_errors or session.config.grader_failed:
                feedbackLogger.error(SEPARATOR)
                feedbackLogger.error('Try again.')
