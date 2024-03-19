class BaseWallet:
    def __init__(self, name, amount):
        self.name = name
        self.amount = amount

    def __str__(self):
        return f'{self.__class__.__name__.replace("Wallet", "")} Wallet {self.name} {self.amount}'

    def to_base(self):
        return self.amount * self.exchange_rate

    def spend_all(self):
        if self.amount > 0:
            self.amount = 0

    def __eq__(self, other):
        return isinstance(other, self.__class__) and self.amount == other.amount

    def __add__(self, other):
        if isinstance(other, (int, float)):
            return self.__class__(self.name, self.amount + other)
        elif isinstance(other, BaseWallet):
            return self.__class__(self.name, self.amount + round(other.to_base() / self.exchange_rate, 2))

    __radd__ = __add__

    def __iadd__(self, other):
        if isinstance(other, (int, float)):
            self.amount = other + self.amount
        elif isinstance(other, BaseWallet):
            self.amount = self.amount + \
                round(other.to_base() / self.exchange_rate, 2)
        return self

    def __sub__(self, other):
        if isinstance(other, (int, float)):
            return self.__class__(self.name, self.amount - other)
        elif isinstance(other, BaseWallet):
            return self.__class__(self.name, round(self.amount - other.to_base() / self.exchange_rate, 2))

    def __rsub__(self, other):
        if isinstance(other, (int, float)):
            return self.__class__(self.name, -self.amount + other)
        elif isinstance(other, BaseWallet):
            return self.__class__(self.name, round(-self.amount + other.to_base() / self.exchange_rate, 2))

    def __isub__(self, other):
        if isinstance(other, (int, float)):
            self.amount -= other
        elif isinstance(other, BaseWallet):
            self.amount -= round(other.to_base() / self.exchange_rate, 2)
        return self

    def __mul__(self, other):
        if isinstance(other, (int, float)):
            return self.__class__(self.name, self.amount * other)

    __rmul__ = __mul__

    def __imul__(self, other):
        if isinstance(other, (int, float)):
            self.amount *= other
        return self

    def __truediv__(self, other):
        if isinstance(other, (int, float)):
            return self.__class__(self.name, self.amount / other)

    __rtruediv__ = __truediv__

    def __itruediv__(self, other):
        if isinstance(other, (int, float)):
            self.amount /= other
        return self


class RubbleWallet(BaseWallet):
    exchange_rate = 1


class DollarWallet(BaseWallet):
    exchange_rate = 60


class EuroWallet(BaseWallet):
    exchange_rate = 70


# Примеры использования:
x_wallet = RubbleWallet("X", 10)
d_wallet = DollarWallet("D", 10)
result1 = x_wallet + 20
result2 = 20 + x_wallet
result3 = x_wallet + d_wallet
result4 = d_wallet + x_wallet
result5 = x_wallet * 20
result6 = x_wallet / 2
result7 = x_wallet - 5
result8 = 5 - x_wallet
result9 = x_wallet - d_wallet
result10 = d_wallet - x_wallet
result11 = x_wallet.to_base()
x_wallet.spend_all()
print(result1)
print(result2)
print(result3)
print(result4)
print(result5)
print(result6)
print(result7)
print(result8)
print(result9)
print(result10)
print(result11)
print(x_wallet)
