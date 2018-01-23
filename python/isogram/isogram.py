def is_isogram(string):
    foundChars = {}

    for char in string:
        loweredChar = char.lower()
        if loweredChar in foundChars:
            return False
        if (loweredChar.isalpha()):
            foundChars[loweredChar] = True

    return True
