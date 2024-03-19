from datetime import date
arr = list(map(int, input().split("-")))
dt = date(arr[2], arr[1], arr[0])
print(date.fromordinal(dt.toordinal()-dt.weekday()).strftime("%d-%m-%Y"))
