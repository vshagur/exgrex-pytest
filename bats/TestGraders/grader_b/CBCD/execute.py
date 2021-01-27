import sys

from exgrex.decorators import CheckSubmissionFilename, CopySolutionFile

from exgrex.graders import UnittestGrader
from exgrexPytest.decorators import RunPytestTests


@CheckSubmissionFilename('solution.py')
@CopySolutionFile()
@RunPytestTests(mode='no', failfast=False, limit=2)
def executeGrader(grader):
    """
    :param grader
    :type grader: Grader
    """
    sys.exit(0)


if __name__ == '__main__':
    grader = UnittestGrader()
    grader.taskName = "Example task."
    executeGrader(grader)
