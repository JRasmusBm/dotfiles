"""
Checks versions of nvim installations
"""
from subprocess import run
from pprint import pprint

import pytest
import requests
from bs4 import BeautifulSoup


@pytest.fixture(scope="module")
def health_checks():
    run(["nvim", "-c", "CheckHealth", "-c", "w! checks.o", "-c", "qa!"])
    raw_checks = str(
        run(["cat", "checks.o"], capture_output=True, check=True).stdout
    )
    run(["rm", "checks.o"])
    raw_sections = [
        section for section in raw_checks.split("==") if bool(section)
    ][-1]
    sections = {
        section.split("\\n")[0].strip(): section
        for section in raw_sections.split("##")
    }
    pprint(sections)
    yield sections


class TestNvim:
    """
    Checks versions of nvim installations
    """

    def test_version(self) -> None:
        """
        Checks that the latest version is being used.
        """
        response = requests.get("https://github.com/neovim/neovim/releases")
        soup = BeautifulSoup(response.content, features="html.parser")
        nvim_version = [
            section.text.split() for section in soup.select(".release-header")
        ][0][0][1:]
        assert nvim_version in str(
            run(["nvim", "--version"], capture_output=True, check=True).stdout
        )

    def test_node_provider(self, health_checks) -> None:
        """
        Checks that there are no node warnings
        """
        assert (
            "warning"
            not in health_checks["Node.js provider (optional)"].lower()
        )

    def test_python_3_provider(self, health_checks) -> None:
        """
        Checks that there are no python 3 warnings
        """
        assert (
            "warning"
            not in health_checks["Python 3 provider (optional)"].lower()
        )

    def test_ruby_provider(self, health_checks) -> None:
        """
        Checks that there are no node warnings
        """
        assert (
            "warning" not in health_checks["Ruby provider (optional)"].lower()
        )

