""" Checks related to the python installation
"""
from subprocess import run

import requests
from bs4 import BeautifulSoup


class TestPython:
    """
    Tests regarding python installation.
    """

    def test_python_38_install(self) -> None:
        """
        Check that we are on python 3.8
        """
        response = requests.get("https://www.python.org/downloads/")
        soup = BeautifulSoup(response.content, features="html.parser")
        python_version = [
            span.text.split()[1]
            for span in soup.select(".release-number")
            if "3.8" in span.text
        ][0]
        assert python_version in str(
            run(["python3.8", "-V"], capture_output=True, check=True).stdout
        )

    def test_python_37_install(self) -> None:
        """
        Check that we are on python 3.8
        """
        response = requests.get("https://www.python.org/downloads/")
        soup = BeautifulSoup(response.content, features="html.parser")
        python_version = [
            span.text.split()[1]
            for span in soup.select(".release-number")
            if "3.7" in span.text
        ][0]
        assert python_version in str(
            run(["python3.7", "-V"], capture_output=True, check=True).stdout
        )
