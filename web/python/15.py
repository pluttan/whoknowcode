import json


def mean_age(json_string):
    people = json.loads(json_string)
    total_age = sum(person['age'] for person in people)
    return json.dumps({"mean_age": total_age / len(people)})


# Пример использования функции
input_json = '''
[
    {
        "name": "Петр",
        "surname": "Петров",
        "patronymic": "Васильевич",
        "age": 23,
        "occupation": "ойтишнек"
    },
    {
        "name": "Василий",
        "surname": "Васильев",
        "patronymic": "Петрович",
        "age": 24,
        "occupation": "дворник"
    }
]
'''

output_json = mean_age(input_json)
print(output_json)  # Выведет '{"mean_age": 23.5}'
