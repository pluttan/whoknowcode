import psycopg2
from urllib.parse import urlparse

# Разбор строки подключения
url = urlparse("postgresql://pluttan:Pluttan@localhost:5432/lab2")

# Создание параметров подключения
db_params = {
    'host': url.hostname,
    'database': url.path[1:],
    'user': url.username,
    'password': url.password,
    'port': url.port,
}
print(db_params)

# Подключение к базе данных
connection = psycopg2.connect(**db_params)
cursor = connection.cursor()

# Пример SQL-запроса
cursor.execute("SELECT * FROM student")
data = cursor.fetchall()
# print(data)

# Закрытие соединения
cursor.close()
connection.close()
