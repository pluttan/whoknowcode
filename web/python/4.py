str = input()
strLower = str.lower().split()
str = str.split()
sub = input().lower()
for i in range(len(str)):
    if (sub in strLower[i]):
        print(str[i])
