str = input().strip()
while ("  " in str):
    str = str.replace("  ", " ")
print("*".join(str.split()))
