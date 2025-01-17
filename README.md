# snowman-db
Database for Snowman project
1) snowman_\*.sql - main database

Чтобы получить занчиния типов данных, либо как массив, либо как набор строк, можно применить следующие запросы

-- Получить все статусы инвойса как массив
SELECT enum_range(NULL::invoice_status);
-- Получить все статусы инвойса как набор строк
SELECT unnest(enum_range(NULL::invoice_status));


-- Получить все уровни занятий как массив
SELECT enum_range(NULL::ability_level);
-- Получить все уровни занятий как набор строк
SELECT unnest(enum_range(NULL::ability_level));


-- Получить все типы курсов как массив
SELECT enum_range(NULL::course_type);
-- Получить все виды курсов как набор строк
SELECT unnest(enum_range(NULL::course_type));


Таблица с датами уже заполнена, но если потребуется заполнить таблицу с датами набором дат, можно выполнить хранимую процедуру, где указать начальную и конечную дату.

call fillDates('2025-01-01', '2050-12-31');