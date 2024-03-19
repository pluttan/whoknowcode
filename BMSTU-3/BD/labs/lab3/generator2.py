from faker import Faker
from random import randint
import psycopg2
from urllib.parse import urlparse
from time import time_ns
import json

fake = Faker("ru_RU")
sq = 1

url = urlparse("postgresql://pluttan:Pluttan@localhost:5432/lab2")

db_params = {
    "host": url.hostname,
    "database": url.path[1:],
    "user": url.username,
    "password": url.password,
    "port": url.port,
}


def generate_tsvector(description):
    connection = psycopg2.connect(**db_params)
    cursor = connection.cursor()
    cursor.execute("SELECT to_tsvector('russian', %s)", (description,))
    tsvector = cursor.fetchone()[0]
    cursor.close()
    connection.close()
    return tsvector


def format_description():
    description = " ".join(fake.sentences(randint(1, 4)))
    return (
        description,
        json.dumps(
            {
                f"Предложение {i + 1}": sentence
                for i, sentence in enumerate(description.split(". "))
            },
            ensure_ascii=False,
        ),
        description.split(" "),
        generate_tsvector(description),
    )


def specialization():
    return "ivt" if randint(0, 1) else "pi"


def squadAndYear():
    global sq
    sq += 1
    year = 2023 if randint(0, 1) else 2022
    return ("ИУ6-" + str(3 if year == 2022 else 1) + str(sq) + "Б", year)


def ship():
    return randint(1000, 10000)


def fid():
    return 1


connection = psycopg2.connect(**db_params)
cursor = connection.cursor()
a = time_ns()
new_b = a
for i in range(1_000_000):
    cursor.execute(
        "INSERT INTO education (specialization, squad, nyear, ship, faculty_id, datatext, data, dataarray, data_tsvector) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
        (specialization(), *squadAndYear(), ship(), fid(), *format_description()),
    )
    if i % 10 == 0:
        b = time_ns()
        print(i, b - new_b, b - a)
        new_b = b

connection.commit()
cursor.close()
connection.close()
