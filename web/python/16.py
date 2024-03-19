class Calculator:
    last = None

    def __init__(self):
        self.history_log = []

    def sum(self, a, b):
        result = a + b
        self._update_last(f"sum({a}, {b}) == {result}")
        return result

    def sub(self, a, b):
        result = a - b
        self._update_last(f"sub({a}, {b}) == {result}")
        return result

    def mul(self, a, b):
        result = a * b
        self._update_last(f"mul({a}, {b}) == {result}")
        return result

    def div(self, a, b, mod=False):
        result = a % b if mod else a / b
        self._update_last(
            f"div({a}, {b}) == {round(result, 1) if mod else result}")
        return result

    def history(self, n):
        return False if n > len(self.history_log) else self.history_log[-n]

    @classmethod
    def clear(cls):
        cls.last = None

    def _update_last(self, operation):
        self.history_log.append(operation)
        Calculator.last = operation


Calculator().div(3, 2, 1)
print(Calculator().last)
