import re


def check_string(string):
    phone = r'^(\+7|8)?[\s\-]?\(?\d{3}\)?[\s\-]?\d{3}[\s\-]?\d{2}[\s\-]?\d{2}$'
    email = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return bool(re.match(phone, string) or re.match(email, string))


input_string = "+7-916-000-00-00"
result = check_string(input_string)
print(result)

for i in [
    "89160000000",
    "+79160000000",
    "9160000000",
    "8(916)000-00-00",
    "+7(916)000-00-00",
    "(916)000-00-00",
    "8 (916) 000-00-00",
    "+7 (916) 000-00-00",
    "(916) 000-00-00",
    "8(916)0000000",
    "+7(916)0000000",
    "(916)0000000",
    "8-916-000-00-00",
    "+7-916-000-00-00",
    "916-000-00-00",
]:
    print(check_string(i))

print()
print()

for i in [
    "abc@abc.ab",
    "abc@abc.ab.ab",
    "a@ab.ab",
    "abc.abc@abc.abc"
]:
    print(check_string(i))

print()
print()

for i in [
    "@abc.abc",
    "abc@abc",
    "abc@abc.a",
    "abc@abc.abc.a",
    "abc@abc.",
    "abc@abc@abc"
]:
    print(check_string(i))

print()
print()
