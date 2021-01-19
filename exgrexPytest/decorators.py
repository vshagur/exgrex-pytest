import subprocess
from functools import wraps


class RunPytestTests:

    def __init__(self, mode='default', args=None):
        self.mode = mode
        if args is None:
            self.args = []
        else:
            self.args = args

    def __call__(self, func):
        @wraps(func)
        def wrapper(grader):
            args = [
                f'pytest',
                f'--grader-mode={self.mode}',
                f'--taskname="{grader.taskName}"', ]

            if self.mode == 'user':
                args.extend(self.args)
            elif self.mode == 'default':
                args.extend(['--tb=short', '-x'])
            elif self.mode == 'other_mode':
                # TODO: add modes
                # created vshagur@gmail.com, 2021-01-19
                pass
            else:
                # TODO: add code
                # created vshagur@gmail.com, 2021-01-19
                pass

            args.append(f'{grader.testsDir}')

            subprocess.run(
                args,
                stderr=subprocess.STDOUT,
                stdout=subprocess.PIPE,
                universal_newlines=True,
                cwd=grader.cwd
            )
            return func(grader)

        return wrapper
