"""
Checks versions of git installations
"""
from subprocess import run

import requests
from bs4 import BeautifulSoup

class TestGit:
    """
    Checks versions of git installations
    """

    def test_gh(self, ) -> None:
        """
        Checks that gh is at the latest version
        """
        response = requests.get("https://github.com/cli/cli/releases")
        soup = BeautifulSoup(response.content, features="html.parser")
        gh_version = [
            section.text.split()
            for section in soup.select(".release-header")
        ][0][0][1:]
        assert gh_version in str(
            run(["gh", "--version"], capture_output=True, check=True).stdout
        )
