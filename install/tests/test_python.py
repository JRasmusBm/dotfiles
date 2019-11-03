""" Checks related to the python installation
"""
from subprocess import run


class TestPython:
    """
    Tests regarding python installation.
    """

    def test_python_version(self) -> None:
        """
        Check that we are on python 3.8
        """
        assert "3.8.0" in str(
            run(["python", "-V"], capture_output=True, check=True).stdout
        )
