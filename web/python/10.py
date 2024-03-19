import datetime
birthdays = {"Иванов Иван Иванович": datetime.date(
    1989, 1, 1), "Петров Петр Петрович": datetime.date(1998, 1, 6)}


def gift_count(budget, month, birthdays):
    count = 0
    hashbrs = {}
    result = f"Именинники в месяце {month}:"
    for i in birthdays.keys():
        if (birthdays[i].month == month):
            result += f" {i} ({birthdays[i].strftime('%d.%m.%Y')}),"
            count += 1
    if (count == 0):
        print("В этом месяце нет именинников.")
    else:
        print(
            result[:-1] + f". При бюджете {budget} они получат по {budget//count} рублей.")


print(gift_count(20000, 1, birthdays))


"""
Выведено: 
Именинники в месяце 1: Катя (01.01.1989), Ваня (06.01.1971). При бюджете 20000 они получат по 10000 рублей.
; должно быть: 
Именинники в месяце 1: Катя (01.01.1989), Ваня (06.01.1971). При бюджете 20000 они получат по 10000 рублей.
make: *** [run] Error 1
"""
