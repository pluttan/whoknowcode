hash = {}
arr = input().split(", ")
for i in arr:
    if (hash.get(i) == None):
        hash.update({i: 1})
    else:
        hash[i] += 1

hash = dict(reversed(sorted(hash.items(), key=lambda item: item[1])))
n = 0
for i in hash.items():
    print(f"{i[0]}: {i[1]}")
    n += 1
    if (n == 3):
        break
