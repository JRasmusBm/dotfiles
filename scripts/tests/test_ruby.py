
"""
Checks versions of ruby installations
"""
from subprocess import run
from pprint import pprint

import pytest
import requests
from bs4 import BeautifulSoup


class TestRuby:
    """
    Checks versions of ruby installations
    """

    def test_version(self) -> None:
        """
        Checks that the latest version is being used.
        """
        response = requests.get("https://www.ruby-lang.org/en/downloads/")
        soup = BeautifulSoup(response.content, features="html.parser")
        ruby_version = soup.select("ul")[1].ul.li.text.split()[1]
        assert ruby_version in str(
            run(["ruby", "--version"], capture_output=True, check=True).stdout
        )
