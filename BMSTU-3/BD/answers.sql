-- 1-1-1 Сформулируйте SQL запрос для создания таблицы book, занесите его в окно кода (расположено ниже) и отправьте на проверку (кнопка Отправить).
create table
    book (
        book_id int primary key auto_increment,
        title varchar(50),
        author varchar(30),
        price decimal(8, 2),
        amount int
    );

-- 1-1-2 Занесите новую строку в таблицу book (текстовые значения (тип VARCHAR) заключать либо в двойные, либо в одинарные кавычки)
insert into
    book (book_id, title, author, price, amount)
values
    (
        1,
        'Мастер и Маргарита',
        'Булгаков М.А.',
        670.99,
        3
    );

-- 1-1-3 Занесите три последние записи в таблицу book,  первая запись уже добавлена на предыдущем шаге:
insert into
    book (book_id, title, author, price, amount)
values
    (2, 'Белая гвардия', 'Булгаков М.А.', 540.50, 5);

insert into
    book (book_id, title, author, price, amount)
values
    (3, 'Идиот', 'Достоевский Ф.М.', 460.00, 10);

insert into
    book (book_id, title, author, price, amount)
values
    (
        4,
        'Братья Карамазовы',
        'Достоевский Ф.М.',
        799.01,
        2
    );

-- 1-2-1 Вывести информацию о всех книгах, хранящихся на складе.
select
    *
from
    book;

-- 1-2-2 Выбрать авторов, название книг и их цену из таблицы book.
select
    author,
    title,
    price
from
    book;

-- 1-2-3 Выбрать названия книг и авторов из таблицы book, для поля title задать имя(псевдоним) Название, для поля author –  Автор.
select
    title as Название,
    author as Автор
from
    book;

-- 1-2-4 Для упаковки каждой книги требуется один лист бумаги, цена которого 1 рубль 65 копеек. Посчитать стоимость упаковки для каждой книги (сколько денег потребуется, чтобы упаковать все экземпляры книги). В запросе вывести название книги, ее количество и стоимость упаковки, последний столбец назвать pack.
select
    title,
    amount,
    1.65 * amount as pack
from
    book;

-- 1-2-5 В конце года цену всех книг на складе пересчитывают – снижают ее на 30%. Написать SQL запрос, который из таблицы book выбирает названия, авторов, количества и вычисляет новые цены книг. Столбец с новой ценой назвать new_price, цену округлить до 2-х знаков после запятой.
select
    title,
    author,
    amount,
    round(price - price / 100 * 30, 2) as new_price
from
    book;

-- 1-2-6 При анализе продаж книг выяснилось, что наибольшей популярностью пользуются книги Михаила Булгакова, на втором месте книги Сергея Есенина. Исходя из этого решили поднять цену книг Булгакова на 10%, а цену книг Есенина - на 5%. Написать запрос, куда включить автора, название книги и новую цену, последний столбец назвать new_price. Значение округлить до двух знаков после запятой.
select
    author,
    title,
    if (
        author = 'Булгаков М.А.',
        round(price / 100 * 110, 2),
        if (
            author = 'Есенин С.А.',
            round(price / 100 * 105, 2),
            price
        )
    ) as new_price
from
    book;

-- 1-2-7 Вывести автора, название  и цены тех книг, количество которых меньше 10.
select
    author,
    title,
    price
from
    book
where
    amount < 10;

-- 1-2-8 Вывести название, автора,  цену  и количество всех книг, цена которых меньше 500 или больше 600, а стоимость всех экземпляров этих книг больше или равна 5000.
select
    title,
    author,
    price,
    amount
from
    book
where
    (
        (price < 500)
        or (price > 600)
    )
    and (amount * price >= 5000);

-- 1-2-9 Вывести название и авторов тех книг, цены которых принадлежат интервалу от 540.50 до 800 (включая границы),  а количество или 2, или 3, или 5, или 7 .
select
    title,
    author
from
    book
where
    (
        (price >= 540.50)
        and (price <= 800)
    )
    and (
        (amount = 2)
        or (amount = 3)
        or (amount = 5)
        or (amount = 7)
    );

-- 1-2-10 Вывести  автора и название  книг, количество которых принадлежит интервалу от 2 до 14 (включая границы). Информацию  отсортировать сначала по авторам (в обратном алфавитном порядке), а затем по названиям книг (по алфавиту).
select
    author,
    title
from
    book
where
    (
        (amount >= 2)
        and (amount <= 14)
    )
order by
    author desc,
    title;

-- 1-2-11 Вывести название и автора тех книг, название которых состоит из двух и более слов, а инициалы автора содержат букву «С». Считать, что в названии слова отделяются друг от друга пробелами и не содержат знаков препинания, между фамилией автора и инициалами обязателен пробел, инициалы записываются без пробела в формате: буква, точка, буква, точка. Информацию отсортировать по названию книги в алфавитном порядке.
select
    title,
    author
from
    book
where
    (title like "_% _%")
    and (
        (author like "_% С._.")
        or (author like "_% _.С.")
    )
order by
    title;

-- 1-3-1 Отобрать различные (уникальные) элементы столбца amount таблицы book.
select distinct
    amount
from
    book;

-- 1-3-2 Посчитать, количество различных книг и количество экземпляров книг каждого автора , хранящихся на складе.  Столбцы назвать Автор, Различных_книг и Количество_экземпляров соответственно.
select
    author as Автор,
    count(title) as Различных_книг,
    sum(amount) as Количество_экземпляров
from
    book
group by
    author;

-- 1-3-3 Вывести фамилию и инициалы автора, минимальную, максимальную и среднюю цену книг каждого автора . Вычисляемые столбцы назвать Минимальная_цена, Максимальная_цена и Средняя_цена соответственно.
select
    author,
    min(price) as Минимальная_цена,
    max(price) as Максимальная_цена,
    avg(price) as Средняя_цена
from
    book
group by
    author;

-- 1-3-4 Для каждого автора вычислить суммарную стоимость книг S (имя столбца Стоимость), а также вычислить налог на добавленную стоимость  для полученных сумм (имя столбца НДС ) , который включен в стоимость и составляет 18% (k=18),  а также стоимость книг  (Стоимость_без_НДС) без него. Значения округлить до двух знаков после запятой.
select
    author,
    round(sum(amount * price), 2) as Стоимость,
    round(
        (sum(amount * price) * 18 / 100) / (1 + 18 / 100),
        2
    ) as НДС,
    round((sum(amount * price)) / (1 + 18 / 100), 2) as Стоимость_без_НДС
from
    book
group by
    author;

-- 1-3-5 Вывести  цену самой дешевой книги, цену самой дорогой и среднюю цену уникальных книг на складе. Названия столбцов Минимальная_цена, Максимальная_цена, Средняя_цена соответственно. Среднюю цену округлить до двух знаков после запятой.
select
    min(price) as Минимальная_цена,
    max(price) as Максимальная_цена,
    round(avg(price), 2) as Средняя_цена
from
    book;

-- 1-3-6 Вычислить среднюю цену и суммарную стоимость тех книг, количество экземпляров которых принадлежит интервалу от 5 до 14, включительно. Столбцы назвать Средняя_цена и Стоимость, значения округлить до 2-х знаков после запятой.
select
    round(avg(price), 2) as Средняя_цена,
    sum(price * amount) as Стоимость
from
    book
where
    amount >= 5
    and amount <= 14;

-- 1-3-7 Посчитать стоимость всех экземпляров каждого автора без учета книг «Идиот» и «Белая гвардия». В результат включить только тех авторов, у которых суммарная стоимость книг (без учета книг «Идиот» и «Белая гвардия») более 5000 руб. Вычисляемый столбец назвать Стоимость. Результат отсортировать по убыванию стоимости.
select
    author,
    sum(price * amount) as Стоимость
from
    book
where
    (
        title <> "Идиот"
        and title <> "Белая гвардия"
    )
group by
    author
having
    sum(amount * price) > 5000
order by
    author desc;

-- 1-4-1 Вывести информацию (автора, название и цену) о  книгах, цены которых меньше или равны средней цене книг на складе. Информацию вывести в отсортированном по убыванию цены виде. Среднее вычислить как среднее по цене книги.
select
    author,
    title,
    price
from
    book
where
    price <= (
        select
            avg(price)
        from
            book
    )
order by
    price desc;

-- 1-4-2 Вывести информацию (автора, название и цену) о тех книгах, цены которых превышают минимальную цену книги на складе не более чем на 150 рублей в отсортированном по возрастанию цены виде.
select
    author,
    title,
    price
from
    book
where
    price <= (
        select
            min(price)
        from
            book
    ) + 150
order by
    price;

-- 1-4-3 Вывести информацию (автора, книгу и количество) о тех книгах, количество экземпляров которых в таблице book не дублируется.
select
    author,
    title,
    amount
from
    book
where
    amount in (
        select
            amount
        from
            book
        group by
            amount
        having
            count(amount) = 1
    );

-- 1-4-4 Вывести информацию о книгах(автор, название, цена), цена которых меньше самой большой из минимальных цен, вычисленных для каждого автора.
select
    author,
    title,
    price
from
    book
where
    price < any (
        select
            min(price)
        from
            book
        group by
            author
    );

-- 1-4-5 Посчитать сколько и каких экземпляров книг нужно заказать поставщикам, чтобы на складе стало одинаковое количество экземпляров каждой книги, равное значению самого большего количества экземпляров одной книги на складе. Вывести название книги, ее автора, текущее количество экземпляров на складе и количество заказываемых экземпляров книг. Последнему столбцу присвоить имя Заказ. В результат не включать книги, которые заказывать не нужно.
select
    title,
    author,
    amount,
    (
        select
            max(amount)
        from
            book
    ) - amount as Заказ
from
    book
having
    Заказ > 0;

-- 1-5-1 Создать таблицу поставка (supply), которая имеет ту же структуру, что и таблиц book.
create table
    supply (
        supply_id INT PRIMARY KEY AUTO_INCREMENT,
        title VARCHAR(50),
        author VARCHAR(30),
        price DECIMAL(8, 2),
        amount INT
    );

-- 1-5-2 Занесите в таблицу supply четыре записи
insert into
    supply (title, author, price, amount)
values
    ('Лирика', 'Пастернак Б.Л.', 518.99, 2),
    ('Черный человек', 'Есенин С.А.', 570.20, 6),
    ('Белая гвардия', 'Булгаков М.А.', 540.50, 7),
    ('Идиот', 'Достоевский Ф.М.', 360.80, 3);

-- 1-5-3 Добавить из таблицы supply в таблицу book, все книги, кроме книг, написанных Булгаковым М.А. и Достоевским Ф.М.
insert into
    book (title, author, price, amount)
select
    title,
    author,
    price,
    amount
from
    supply
where
    author <> 'Булгаков М.А.'
    and author <> 'Достоевский Ф.М.';

-- 1-5-4 Занести из таблицы supply в таблицу book только те книги, авторов которых нет в  book.
insert into
    book (title, author, price, amount)
select
    title,
    author,
    price,
    amount
from
    supply
where
    author <> all (
        select
            author
        from
            book
    );

-- 1-5-5 Уменьшить на 10% цену тех книг в таблице book, количество которых принадлежит интервалу от 5 до 10, включая границы.
update book
set
    price = 0.9 * price
where
    amount >= 5
    and amount <= 10;

-- 1-5-6 В таблице book необходимо скорректировать значение для покупателя в столбце buy таким образом, чтобы оно не превышало количество экземпляров книг, указанных в столбце amount. А цену тех книг, которые покупатель не заказывал, снизить на 10%.
update book
set
    price = if (buy = 0, 0.9 * price, price),
    buy = if (buy > amount, amount, buy);

-- 1-5-7 Для тех книг в таблице book , которые есть в таблице supply, не только увеличить их количество в таблице book ( увеличить их количество на значение столбца amountтаблицы supply), но и пересчитать их цену (для каждой книги найти сумму цен из таблиц book и supply и разделить на 2).
update book b,
supply s
set
    b.amount = b.amount + s.amount,
    b.price = (b.price + s.price) / 2
where
    b.title = s.title;

-- 1-5-8 Удалить из таблицы supply книги тех авторов, общее количество экземпляров книг которых в таблице book превышает 10.
delete from supply
where
    author in (
        select
            author
        from
            book
        group by
            author
        having
            sum(amount) > 10
    );

-- 1-5-9 Создать таблицу заказ (ordering), куда включить авторов и названия тех книг, количество экземпляров которых в таблице book меньше среднего количества экземпляров книг в таблице book. В таблицу включить столбец   amount, в котором для всех книг указать одинаковое значение - среднее количество экземпляров книг в таблице book.
create table
    ordering as
select
    author,
    title,
    (
        select
            avg(amount)
        from
            book
    ) as amount
from
    book
where
    amount < (
        select
            avg(amount)
        from
            book
    );

-- 1-6-1 Вывести из таблицы trip информацию о командировках тех сотрудников, фамилия которых заканчивается на букву «а», в отсортированном по убыванию даты последнего дня командировки виде. В результат включить столбцы name, city, per_diem, date_first, date_last.
select
    name,
    city,
    per_diem,
    date_first,
    date_last
from
    trip
where
    name like "_%а _._."
order by
    date_last desc;

-- 1-6-2 Вывести в алфавитном порядке фамилии и инициалы тех сотрудников, которые были в командировке в Москве.
select distinct
    name
from
    trip
where
    city = 'Москва'
order by
    name;

-- 1-6-3 Для каждого города посчитать, сколько раз сотрудники в нем были.  Информацию вывести в отсортированном в алфавитном порядке по названию городов. Вычисляемый столбец назвать Количество.
select
    city,
    count(city) as Количество
from
    trip
group by
    city
order by
    city;

-- 1-6-4 Вывести два города, в которых чаще всего были в командировках сотрудники. Вычисляемый столбец назвать Количество.
select
    city,
    count(city) as Количество
from
    trip
group by
    city
order by
    Количество desc
limit
    2;

-- 1-6-5 Вывести информацию о командировках во все города кроме Москвы и Санкт-Петербурга (фамилии и инициалы сотрудников, город ,  длительность командировки в днях, при этом первый и последний день относится к периоду командировки). Последний столбец назвать Длительность. Информацию вывести в упорядоченном по убыванию длительности поездки, а потом по убыванию названий городов (в обратном алфавитном порядке).
select
    name,
    city,
    datediff (date_last, date_first) + 1 as Длительность
from
    trip
where
    city <> "Москва"
    and city <> "Санкт-Петербург"
order by
    Длительность desc,
    city desc;

-- 1-6-6 Вывести информацию о командировках сотрудника(ов), которые были самыми короткими по времени. В результат включить столбцы name, city, date_first, date_last.
select
    name,
    city,
    date_first,
    date_last
from
    trip
where
    datediff (date_last, date_first) = (
        select
            min(datediff (date_last, date_first))
        from
            trip
    );

-- 1-6-7 Вывести информацию о командировках, начало и конец которых относятся к одному месяцу (год может быть любой). В результат включить столбцы name, city, date_first, date_last. Строки отсортировать сначала  в алфавитном порядке по названию города, а затем по фамилии сотрудника .
select
    name,
    city,
    date_first,
    date_last
from
    trip
where
    MONTH (date_first) = MONTH (date_last)
order by
    city,
    name;

-- 1-6-8 Вывести название месяца и количество командировок для каждого месяца. Считаем, что командировка относится к некоторому месяцу, если она началась в этом месяце. Информацию вывести сначала в отсортированном по убыванию количества, а потом в алфавитном порядке по названию месяца виде. Название столбцов – Месяц и Количество.
select
    MONTHNAME (date_first) as Месяц,
    count(MONTHNAME (date_first)) as Количество
from
    trip
group by
    Месяц
order by
    Количество desc,
    Месяц;

-- 1-6-9 Вывести сумму суточных (произведение количества дней командировки и размера суточных) для командировок, первый день которых пришелся на февраль или март 2020 года. Значение суточных для каждой командировки занесено в столбец per_diem. Вывести фамилию и инициалы сотрудника, город, первый день командировки и сумму суточных. Последний столбец назвать Сумма. Информацию отсортировать сначала  в алфавитном порядке по фамилиям сотрудников, а затем по убыванию суммы суточных.
select
    name,
    city,
    date_first,
    (datediff (date_last, date_first) + 1) * per_diem as Сумма
from
    trip
where
    (
        month (date_first) = 2
        or month (date_first) = 3
    )
    and year (date_first) = 2020
order by
    name,
    per_diem;

-- 1-6-10 Вывести фамилию с инициалами и общую сумму суточных, полученных за все командировки для тех сотрудников, которые были в командировках больше чем 3 раза, в отсортированном по убыванию сумм суточных виде. Последний столбец назвать Сумма.
select
    name,
    sum((datediff (date_last, date_first) + 1) * per_diem) as Сумма
from
    trip
group by
    name
having
    name = any (
        select
            name as r
        from
            trip
        group by
            name
        having
            count(name) > 3
    )
order by
    Сумма desc;

-- 1-7-1 Создать таблицу fine следующей структуры
create table
    fine (
        fine_id int primary key auto_increment,
        name varchar(30),
        number_plate varchar(6),
        violation varchar(50),
        sum_fine decimal(8, 2),
        date_violation date,
        date_payment date
    );

-- 1-7-2 В таблицу fine первые 5 строк уже занесены. Добавить в таблицу записи с ключевыми значениями 6, 7, 8.
insert into
    fine (name, number_plate, violation, date_violation)
values
    (
        'Баранов П.Е.',
        'Р523ВТ',
        'Превышение скорости(от 40 до 60)',
        '2020-02-14'
    ),
    (
        'Абрамова К.А.',
        'О111АВ',
        'Проезд на запрещающий сигнал',
        '2020-02-23'
    ),
    (
        'Яковлев Г.Р.',
        'Т330ТТ',
        'Проезд на запрещающий сигнал',
        '2020-03-03'
    );

-- 1-7-3 Занести в таблицу fine суммы штрафов, которые должен оплатить водитель, в соответствии с данными из таблицы traffic_violation. При этом суммы заносить только в пустые поля столбца  sum_fine. Таблица traffic_violationсоздана и заполнена.
update fine
set
    fine.sum_fine = (
        select
            sum_fine
        from
            traffic_violation
        where
            violation = fine.violation
    )
where
    fine.sum_fine is null;

-- 1-7-4 Вывести фамилию, номер машины и нарушение только для тех водителей, которые на одной машине нарушили одно и то же правило   два и более раз. При этом учитывать все нарушения, независимо от того оплачены они или нет. Информацию отсортировать в алфавитном порядке, сначала по фамилии водителя, потом по номеру машины и, наконец, по нарушению.
SELECT
    name,
    number_plate,
    violation
FROM
    fine
GROUP BY
    name,
    number_plate,
    violation
having
    count(*) > 1
order by
    name,
    number_plate,
    violation;

-- 1-7-5 В таблице fine увеличить в два раза сумму неоплаченных штрафов для отобранных на предыдущем шаге записей. 
update fine f,
(
    select
        name,
        number_plate,
        violation
    from
        fine
    group by
        name,
        number_plate,
        violation
    having
        count(*) > 1
) q_in
set
    f.sum_fine = f.sum_fine * 2
where
    (f.name, f.number_plate, f.violation) = (q_in.name, q_in.number_plate, q_in.violation)
    and f.date_payment is Null;

-- 1-7-6 в таблицу fine занести дату оплаты соответствующего штрафа из таблицы payment; уменьшить начисленный штраф в таблице fine в два раза  (только для тех штрафов, информация о которых занесена в таблицу payment) , если оплата произведена не позднее 20 дней со дня нарушения.
update fine,
payment
set
    fine.date_payment = payment.date_payment,
    fine.sum_fine = if (
        datediff (payment.date_payment, fine.date_violation) <= 20,
        fine.sum_fine / 2,
        fine.sum_fine
    )
where
    (payment.name = fine.name)
    and (payment.violation = fine.violation)
    and (payment.number_plate = fine.number_plate)
    and (payment.date_violation = fine.date_violation);

-- 1-7-7 Создать новую таблицу back_payment, куда внести информацию о неоплаченных штрафах (Фамилию и инициалы водителя, номер машины, нарушение, сумму штрафа  и  дату нарушения) из таблицы fine.
create table
    back_payment
select
    name,
    number_plate,
    violation,
    sum_fine,
    date_violation
from
    fine
where
    date_payment is NULL;

-- 1-7-8 Удалить из таблицы fine информацию о нарушениях, совершенных раньше 1 февраля 2020 года.
delete from fine
where
    date_violation < '2020-02-01';

-- 2-1-1 Создать таблицу author
create table
    author (
        author_id int primary key auto_increment,
        name_author varchar(30)
    );

-- 2-1-2 Заполнить таблицу author. В нее включить следующих авторов: Булгаков М.А. Достоевский Ф.М. Есенин С.А. Пастернак Б.Л.
insert into
    author (name_author)
values
    ('Булгаков М.А.'),
    ('Достоевский Ф.М.'),
    ('Есенин С.А.'),
    ('Пастернак Б.Л.');

-- 2-1-3 Перепишите запрос на создание таблицы book , чтобы ее структура соответствовала структуре, показанной на логической схеме
select
    *
from
    author;

create table
    book (
        book_id int primary key auto_increment,
        title varchar(50),
        author_id int not null,
        genre_id int,
        price decimal(8, 2),
        amount int,
        foreign key (author_id) references author (author_id),
        foreign key (genre_id) references genre (genre_id)
    );

-- 2-1-4 Создать таблицу book той же структуры, что и на предыдущем шаге. Будем считать, что при удалении автора из таблицы author, должны удаляться все записи о книгах из таблицы book, написанные этим автором. А при удалении жанра из таблицы genre для соответствующей записи book установить значение Null в столбце genre_id.
create table
    book (
        book_id int primary key auto_increment,
        title varchar(50),
        author_id int not null,
        genre_id int,
        price decimal(8, 2),
        amount int,
        foreign key (author_id) references author (author_id) on delete cascade,
        foreign key (genre_id) references genre (genre_id) on delete set null
    );

-- 2-1-5 Добавьте три последние записи (с ключевыми значениями 6, 7, 8) в таблицу book, первые 5 записей уже добавлены
insert into
    book (title, author_id, genre_id, price, amount)
values
    ('Стихотворения и поэмы', 3, 2, 650.00, 15),
    ('Черный человек', 3, 2, 570.20, 6),
    ('Лирика', 4, 2, 518.99, 2);