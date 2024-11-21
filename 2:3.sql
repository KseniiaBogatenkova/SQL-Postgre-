-- Отберите продавцов, зарегистрированных в 2022 году и продающих ровно 2 категории товаров с суммарной выручкой, превышающей 75 000.
-- Выведите seller_id данных продавцов, а также столбец category_pair с наименованиями категорий, которые продают данные селлеры.
-- Например, если селлер продает товары категорий “Game”, “Fitness”, то для него необходимо вывести пару категорий category_pair
-- с разделителем “-” в алфавитном порядке (т.е. “Game - Fitness”).
-- Поля в результирующей таблице: seller_id, category_pair


WITH sellers_2022 AS (
    SELECT 
        seller_id,
        STRING_AGG(DISTINCT category, ' - ' ORDER BY category) AS category_pair,  -- Объединяем категории в строку через " - " в алфавитном порядке
        COUNT(DISTINCT category) AS total_categories,  -- Считаем количество уникальных категорий
        SUM(revenue) AS total_revenue  -- Суммируем выручку
    FROM 
        sellers
    WHERE 
        EXTRACT(YEAR FROM TO_DATE(date_reg, 'DD/MM/YYYY')) = 2022  -- Оставляем только продавцов, зарегистрированных в 2022 году
    GROUP BY 
        seller_id
    HAVING 
        COUNT(DISTINCT category) = 2  -- Условие на количество категорий (ровно 2)
        AND SUM(revenue) > 75000  -- Условие на сумму выручки (больше 75,000)
)
SELECT 
    seller_id,
    category_pair
FROM 
    sellers_2022
ORDER BY 
    seller_id;
