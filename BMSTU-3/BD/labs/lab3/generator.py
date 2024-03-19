import psycopg2
import random
from datetime import datetime, timedelta
from urllib.parse import urlparse
from time import time_ns

def generate_random_name():
    # Примеры русских имен и фамилий
    first_names = ['Иван', 'Мария', 'Александр', 'Екатерина', 'Дмитрий', 'Ольга', 'Сергей', 'Анна', 'Андрей', 'Наталья']
    last_names = ['Иванов', 'Петров', 'Сидоров', 'Козлов', 'Смирнов', 'Кузнецов', 'Морозов', 'Николаев', 'Павлов', 'Васнецов']

    random_name = random.choice(first_names) + " " + random.choice(last_names)
    return random_name

def generate_random_city():
    cities = ['Москва', 'Санкт-Петербург', 'Новосибирск', 'Екатеринбург', 'Нижний Новгород', 'Казань', 'Челябинск', 'Омск', 'Самара', 'Ростов-на-Дону', 'Уфа', 'Красноярск', 'Пермь', 'Воронеж', 'Волгоград', 'Краснодар', 'Саратов', 'Тюмень', 'Ижевск', 'Ульяновск']

    # Генерация уникального города
    unique_cities = list(set(cities))
    random_city = random.choice(unique_cities)

    return random_city

def generate_random_birthdate():
    current_year = 2023
    min_birth_year = current_year - 19
    max_birth_year = current_year - 18

    # Генерация случайной даты в интервале 18-19 лет назад
    birth_year = random.randint(min_birth_year, max_birth_year)
    birth_month = random.randint(1, 12)
    birth_day = random.randint(1, 28)

    birthdate = datetime(birth_year, birth_month, birth_day)
    return birthdate.strftime('%Y-%m-%d')

def generate_random_year():
    return 2022 if random.randint(0, 1) else 2023

# Задайте параметры подключения к базе данных
url = urlparse("postgresql://pluttan:Pluttan@localhost:5432/lab2")

# Создание параметров подключения
db_params = {
    'host': url.hostname,
    'database': url.path[1:],
    'user': url.username,
    'password': url.password,
    'port': url.port,
}
connection = psycopg2.connect(**db_params)
cursor = connection.cursor()
a = time_ns()
new_b = a
for i in range(100_000_000):    
    cursor.execute("INSERT INTO student (sname, birsday, town, nyear, education_id) VALUES (%s, %s, %s, %s, 1)", 
               (generate_random_name(), generate_random_birthdate(), generate_random_city(), generate_random_year())
              )
    if (i%10000 == 0): 
        b = time_ns()
        print(i, b-new_b, b-a)
        new_b = b
        
connection.commit()
cursor.close()
connection.close()
