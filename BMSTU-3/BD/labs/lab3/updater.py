import psycopg2
import random
from datetime import datetime, timedelta
from urllib.parse import urlparse
from time import time_ns

# Задайте параметры подключения к базе данных
url = urlparse("postgresql://pluttan:Pluttan@localhost:5432/lab2")

# Создание параметров подключения
db_params = {
    "host": url.hostname,
    "database": url.path[1:],
    "user": url.username,
    "password": url.password,
    "port": url.port,
}
connection = psycopg2.connect(**db_params)
cursor = connection.cursor()
a = time_ns()
new_b = a
cursor.execute("SELECT id_student FROM student")
rows = cursor.fetchall()
t = 0
for i in rows:
    cursor.execute(
        "UPDATE student SET education_id = %s where id_student = %s",
        (random.randint(1, 1_000_000), i[0]),
    )
    if t % 10000 == 0:
        b = time_ns()
        print(t, i, b - new_b, b - a)
        new_b = b
    t += 1

connection.commit()
cursor.close()
connection.close()
