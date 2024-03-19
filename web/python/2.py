sum = 0
while True:
    inp = input()
    if (inp == ""):
        break
    elif (int(inp) % 2 == 0):
        sum += int(inp)
print(sum)
