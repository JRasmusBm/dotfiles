import time
import pyautogui
import pyperclip
import sys

_, file_name, deck = sys.argv
with open(file_name, encoding="utf-8") as f:
    paragraphs = iter(f.read().split("\n\n"))

questions = ((question, next(paragraphs)) for question in paragraphs)

pyautogui.hotkey("alt", "tab")

for front, back in questions:
    pyautogui.hotkey("esc")
    pyautogui.typewrite("f")
    time.sleep(1)
    pyautogui.typewrite("e")
    pyperclip.copy(deck)
    pyautogui.hotkey("ctrl", "a")
    pyautogui.hotkey("ctrl", "v")
    pyautogui.hotkey("tab")
    pyperclip.copy(front)
    pyautogui.hotkey("ctrl", "a")
    pyautogui.hotkey("ctrl", "v")
    pyautogui.hotkey("tab")
    pyperclip.copy(back)
    pyautogui.hotkey("ctrl", "a")
    pyautogui.hotkey("ctrl", "v")
    pyautogui.hotkey("tab")
    pyautogui.hotkey("tab")
    pyautogui.hotkey("enter")
    time.sleep(1)

pyautogui.hotkey("alt", "tab")
