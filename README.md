## Домашнє завдання 5

### Вкладені запити. Повторне використання коду.

---

## Опис роботи

У цьому домашньому завданні було виконано SQL-запити з використанням вкладених запитів та повторного використання коду.

Під час виконання роботи були використані:

- вкладений запит в операторі `SELECT`
- вкладений запит в операторі `WHERE`
- вкладений запит в операторі `FROM`
- оператор `WITH`
- створення користувацької функції
- `DROP FUNCTION IF EXISTS`
- `DELIMITER`
- `CREATE FUNCTION`
- `SELECT`
- `GROUP BY`
- `AVG`

Для виконання завдання використовувалась база даних `goit_rdb_hw_03`, створена та заповнена під час попереднього домашнього завдання.

---

## Використана база даних

```sql
USE goit_rdb_hw_03;

## Завдання 1

Написати SQL-запит, який відображає таблицю `order_details` та поле `customer_id` з таблиці `orders` для кожного запису з таблиці `order_details`.

Це виконано за допомогою вкладеного запиту в операторі `SELECT`.

```sql
SELECT 
    od.*,
    (
        SELECT o.customer_id
        FROM orders o
        WHERE o.id = od.order_id
    ) AS customer_id
FROM order_details od;
```

---

## Завдання 2

Написати SQL-запит, який відображає таблицю `order_details`, але фільтрує результати так, щоб відповідний запис з таблиці `orders` виконував умову `shipper_id = 3`.

Це виконано за допомогою вкладеного запиту в операторі `WHERE`.

```sql
SELECT *
FROM order_details
WHERE order_id IN (
    SELECT id
    FROM orders
    WHERE shipper_id = 3
);
```

---

## Завдання 3

Написати SQL-запит, вкладений в операторі `FROM`, який обирає рядки з умовою `quantity > 10` з таблиці `order_details`.

Для отриманих даних знайти середнє значення поля `quantity`, групування виконати за `order_id`.

```sql
SELECT 
    temp.order_id,
    AVG(temp.quantity) AS average_quantity
FROM (
    SELECT *
    FROM order_details
    WHERE quantity > 10
) AS temp
GROUP BY temp.order_id;
```

---

## Завдання 4

Розв’язати завдання 3, використовуючи оператор `WITH` для створення тимчасової таблиці `temp`.

```sql
WITH temp AS (
    SELECT *
    FROM order_details
    WHERE quantity > 10
)
SELECT 
    temp.order_id,
    AVG(temp.quantity) AS average_quantity
FROM temp
GROUP BY temp.order_id;
```

---

## Завдання 5

Створити функцію з двома параметрами, яка ділить перший параметр на другий.

Обидва параметри та значення, що повертається, мають тип `FLOAT`.

Функція застосована до атрибута `quantity` таблиці `order_details`. Другим параметром використано число `2`.

```sql
DROP FUNCTION IF EXISTS divide_float;

DELIMITER //

CREATE FUNCTION divide_float(num1 FLOAT, num2 FLOAT)
RETURNS FLOAT
DETERMINISTIC
NO SQL
BEGIN
    RETURN num1 / num2;
END //

DELIMITER ;

SELECT 
    id,
    order_id,
    product_id,
    quantity,
    divide_float(quantity, 2) AS divided_quantity
FROM order_details;
```

---

## Скріншоти

У репозиторії додано скріншоти виконаних SQL-запитів та результатів їх роботи.

назви файлів:

- `p1_select_subquery_customer_id.png`
- `p2_where_subquery_shipper_id_3.png`
- `p3_from_subquery_avg_quantity.png`
- `p4_with_temp_avg_quantity.png`
- `p5_function_divide_quantity.png`

---

## Файли репозиторію

- `hw5.sql`
- `README.md`
- скріншоти з результатами виконання запитів
