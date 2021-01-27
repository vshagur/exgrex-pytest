import pytest
from .solution import summa


# syntax error
# import blb


@pytest.fixture()
def new_summa():
    # raise IndexError
    # pass
    2/0


def test_1(new_summa):
    """passed"""
    assert summa(1, 0) == 1, 'Test 1. assert message test_1'


def test_2(new_summa):
    """failed"""
    assert summa(1, 0) == 5, 'Test 2. assert message test_2'


def test_3():
    """error"""
    # raise ZeroDivisionError
    pass


def test_4():
    """error"""
    with pytest.raises(ZeroDivisionError):
        raise ZeroDivisionError
        # raise IndexError
        # pass


def test_5():
    """failed"""
    assert [1, 2, 3] == [1, 2, 3, 4], 'Test 5. assert message test_5'


@pytest.mark.parametrize('value', [1, 2, 3, 4, 5])
def test_6(value):
    assert value > 0, 'Test 6.assert message test_6'


@pytest.mark.parametrize('value', [1, 2, 3, 4, 5])
def test_7(value):
    assert value in (4, 5), 'Test 7.assert message test_7'


class TestExample:

    @pytest.fixture(scope='class')
    def some_fixture(self):
        # 3/0
        pass

    @classmethod
    def setup_class(cls):
        """ setup any state specific to the execution of the given class (which
        usually contains tests).
        """
        # raise ZeroDivisionError('from setup')
        pass

    @classmethod
    def teardown_class(cls):
        """ teardown any state that was previously setup with a call to
        setup_class.
        """
        pass

    def test_8(self):
        assert True, 'Test 8. assert message test_8'

    def test_9(self):
        assert 'asdf' == 'rty', 'Test 9. assert message test_9'

    def test_10(self, some_fixture):
        assert True, 'Test 10. assert message test_10'

    def test_11(self, new_summa):
        assert new_summa(4, 6) == 10, 'Test 11. assert message test_11'
