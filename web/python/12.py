def count_debts(names, amount, transactions):
    hash = {}
    for i in transactions:
        if (i['name'] in names):
            if (hash.get(i['name']) == None):
                hash.update({i['name']: i['amount']})
            else:
                hash[i['name']] += i['amount']
    for i in names:
        if (hash.get(i) == None):
            hash.update({i: amount})
        else:
            hash[i] = amount - hash[i]
            if (hash[i]) < 0:
                hash[i] = 0
    return hash


print("hello")


def get_balance(name, transactions):
    return 10**10 - count_debts([name], 10**10, transactions)[name]


print(count_debts(["Василий", "Петя", "Вова"], 150,  [{"name": "Василий", "amount": 500}, {
    "name": "Петя", "amount": 100}, {"name": "Василий", "amount": -300}, ]))
print(get_balance("Василий", [{"name": "Василий", "amount": 500}, {
    "name": "Петя", "amount": 100}, {"name": "Василий", "amount": -300}, ]))
