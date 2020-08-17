"""
Checks versions of node installations
"""
from subprocess import run

import requests
from bs4 import BeautifulSoup

class TestNode:
    """
    Checks versions of node installations
    """

    def test_latest_version(self, ) -> None:
        """
        Checks that we're on the latest node version.
        """
        node_version = "12.0.0"
        response = requests.get("https://nodejs.org/en/download/")
        soup = BeautifulSoup(response.content, features="html.parser")
        node_version = [
            section.text.split()
            for section in soup.select("section")
        ][0][3]
        print(node_version)
        assert node_version in str(
            run(["node", "-v"], capture_output=True, check=True).stdout
        )

