arr = []
for i in range(5):
    arr.append(int(input()))
print("\n".join(map(str, reversed(sorted(arr)))))
