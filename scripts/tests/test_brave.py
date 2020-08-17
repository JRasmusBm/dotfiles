"""
Checks versions of brave installations
"""
from subprocess import run

class TestBrave:
    """
    Checks versions of brave installations
    """

    def test_latest_version(self, ) -> None:
        """
        Checks that we're on the latest brave version.
        """
        assert "beta" in str(
            run(["brave-browser", "--version"], capture_output=True, check=True).stdout
        )
