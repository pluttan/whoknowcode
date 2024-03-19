numbers = [
    7.1,
    6.7,
    7.0,
    7.3,
    7.2,
    7.1,
    6.9,
    6.8,
    7.5,
    7.0,
    7.0,
    7.1,
    7.1,
    6.8,
    7.2,
    7.0,
    7.2,
    6.9,
    6.7,
    6.9,
    6.9,
    7.0,
    7.0,
    6.8,
    6.9,
    7.0,
    7.0,
    7.1,
    6.8,
    7.1,
    7.2,
    7.1,
    6.9,
    6.7,
    7.1,
    6.9,
    6.9,
    7.1,
    7.0,
    7.3,
    6.8,
    7.3,
    7.4,
    6.8,
    7.2,
    7.2,
    6.8,
    6.7,
    7.3,
    7.1,
    6.9,
    7.6,
    7.0,
    6.5,
    7.1,
    7.2,
    7.0,
    7.0,
    6.9,
    7.0,
    6.7,
    6.8,
    7.1,
    7.2,
    7.1,
    7.5,
    7.1,
    6.8,
    6.9,
    7.2,
    7.2,
    6.9,
    7.1,
    7.5,
    7.0,
    7.1,
    7.0,
    7.1,
    6.8,
    7.0,
]
from collections import Counter
from math import sqrt
import matplotlib.pyplot as plt


total = sum(numbers)
count = len(numbers)
print(f"Всего чисел: {count}")
average = total / count
print(f"Среднее значение: {average:.2f}")
variance = sum((x - average) ** 2 for x in numbers) / count
print(f"Дисперсия: {variance:.2f}")
print(f"Точечная дисперсия: {sqrt(variance):.2f}")
counted_numbers = Counter(numbers)
sorted_counts = sorted(counted_numbers.items(), key=lambda x: x[0])
for number, count in sorted_counts:
    print(f"Число {number} повторяется {count} раз(а)")
limited_counts = sorted_counts[:100]
x = [number for number, _ in limited_counts]
y = [count for _, count in limited_counts]
colors = [
    "red",
    "green",
    "blue",
    "orange",
    "purple",
]
plt.bar(x, y, color=colors[: len(x)])
plt.xlabel("Число")
plt.ylabel("Количество повторений")
plt.title("Гистограмма повторяющихся чисел")
plt.show()
