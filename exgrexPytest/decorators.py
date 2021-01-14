from functools import wraps


class RunPytestTests:
    def __init__(self, failfast=True, traceback=True, verbosity=1, pass_rate=1):
        self.failfast = failfast
        self.verbosity = verbosity
        self.traceback = traceback
        self.passRate = pass_rate

    def __call__(self, func):
        @wraps(func)
        def wrapper(grader):
            return func(grader)

        return wrapper
