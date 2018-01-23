def is_pangram(sentence):
    foundChars = {}

    for char in sentence.lower():
        if char.isalpha():
            foundChars[char] = True

    return len(foundChars.keys()) == 26
