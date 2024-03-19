import re

class Field:
    def __init__(self):
        self.data = {}

    def _validate_key(self, key):
        if isinstance(key, tuple) and len(key) == 2:
            letter, number = key
            if isinstance(letter, str) and re.match(r'^[A-Za-z]+$', letter) and isinstance(number, (int, str)) and re.match(r'^\d+$', str(number)):
                return True
        elif (isinstance(key, str) and
             (re.match(r'^[A-Za-z]+\d+$', key) or re.match(r'^\d+[A-Za-z]+$', key))):
            return True
        return False

    def _normalize_key(self, key):
        if isinstance(key, tuple):
            letter, number = key
            return str(letter).upper(), str(number)
        elif isinstance(key, str):
            match = re.match(r'^([A-Za-z]+)(\d+)$', key)
            if match:
                return match.group(1).upper(), match.group(2)
        return None, None


    def __getitem__(self, key):
        letter, number = self._normalize_key(key)
        if letter is not None and number is not None:
            return self.data.get((letter, number))

    def __setitem__(self, key, value):
        letter, number = self._normalize_key(key)
        if letter is not None and number is not None:
            self.data[(letter, number)] = value

    def __delitem__(self, key):
        letter, number = self._normalize_key(key)
        if letter is not None and number is not None:
            del self.data[(letter, number)]

    def __contains__(self, key):
        letter, number = self._normalize_key(key)
        return letter is not None and number is not None and (letter, number) in self.data

    def __iter__(self):
        return iter(self.data.values())

field = Field()
field['1A'] = 25
assert field['1A'] == 25
